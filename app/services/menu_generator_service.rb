require 'json'
require 'net/http'
require 'uri'
require 'openssl'

# Service pour interagir avec l'API Gemini et générer le plan de repas.
class MenuGeneratorService
  GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent"

  # Utilisation de la clé depuis les variables d'environnement
  API_KEY = ENV['GEMINI_API_KEY']
  MAX_RETRIES = 5

  def initialize(user_preference)
    @prefs = user_preference
  end

  # Génère l'invite système (persona et règles) pour l'IA (Basé sur ZOE Health)
  def system_prompt
    <<~PROMPT
      Vous êtes un Chef et Nutritionniste IA expert, spécialisé dans les recommandations basées sur la science de la santé intestinale (Microbiote) et anti-inflammatoire, en phase avec les principes de ZOE Health.

      Votre mission est de concevoir un plan de menu hebdomadaire de 7 jours (Petit-déjeuner, Déjeuner, Dîner).

      CONSIGNES ZOE HEALTH FONDAMENTALES :
      1. DIVERSITÉ : Atteindre au moins 30 types de plantes différentes sur la semaine (fruits, légumes, céréales complètes, légumineuses, noix, graines, épices).
      2. QUALITÉ DES GRAISSES : Utiliser de l'huile d'olive extra-vierge, des avocats, et des noix/graines.
      3. ALIMENTS À ÉVITER : Limiter les aliments ultra-transformés et les sucres ajoutés.

      Votre réponse DOIT STRICTEMENT être un objet JSON unique, conforme au schéma JSON fourni. NE PAS inclure de texte explicatif avant ou après le JSON.
    PROMPT
  end

  # Méthode principale pour générer le plan de menu
  def generate_menu
    unless API_KEY.present?
      Rails.logger.error "Erreur: La clé API Gemini est manquante ou invalide dans les variables d'environnement."
      return nil
    end

    user_prompt = create_user_prompt
    schema = create_response_schema

    response = call_gemini_api(user_prompt, schema)

    if response && response['candidates'] && response['candidates'][0]
      json_text = response['candidates'][0]['content']['parts'][0]['text']

      # Tente de nettoyer les délimiteurs Markdown si l'IA les ajoute
      json_text = json_text.gsub(/```json\n?|```\n?/, '').strip

      # Log du JSON parsé pour le débogage final (si nécessaire)
      Rails.logger.info "JSON Parsé de l'API: #{json_text.truncate(100)}"

      return JSON.parse(json_text)
    else
      Rails.logger.error "Erreur lors de l'appel à l'API Gemini: #{response.inspect}"
      nil
    end
  rescue JSON::ParserError => e
    # Log l'erreur de parsing pour aider au débogage
    Rails.logger.error "ERREUR CRITIQUE DE PARSING JSON : #{e.message}. Texte brut reçu : #{json_text.truncate(500)}"
    nil
  rescue StandardError => e
    Rails.logger.error "Erreur inattendue lors de la génération du menu: #{e.message}"
    nil
  end

  private

  # Crée le prompt utilisateur en français
  def create_user_prompt
    allergies_list = @prefs.allergies.any? ? "Exclure absolument ces ingrédients: #{@prefs.allergies.join(', ')}." : ""
    kcal_target = @prefs.calculate_recommended_kcal

    <<~PROMPT
      Générez un plan de repas de 7 jours avec les contraintes suivantes :
      - Cible Calorique Quotidienne : environ #{kcal_target} kcal.
      - Budget Hebdomadaire Maximum : #{@prefs.weekly_budget_max} € (Veuillez estimer les coûts de chaque recette)
      - Temps de Préparation Max par Repas : #{@prefs.max_prep_time_minutes} minutes.
      - Allergies/Intolérances à exclure : #{allergies_list}
    PROMPT
  end

  # Définit le schéma JSON attendu pour garantir la structure de la réponse.
  def create_response_schema
    {
      type: "OBJECT",
      properties: {
        menus: {
          type: "OBJECT",
          properties: ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'].to_h { |day|
            [day, {
              type: "OBJECT",
              properties: {
                "Petit-déjeuner" => recipe_schema,
                "Déjeuner" => recipe_schema,
                "Dîner" => recipe_schema
              },
              required: ["Petit-déjeuner", "Déjeuner", "Dîner"]
            }]
          },
          required: ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche']
        },
        "user_kcal_target" => { type: "NUMBER" },
        "generated_kcal" => { type: "NUMBER" },
        "estimated_cost" => { type: "NUMBER" },
        "cost_ok" => { type: "BOOLEAN" },
        "macros_ok" => { type: "BOOLEAN" },
        "diversity_summary" => { type: "STRING" }
      },
      required: ["menus", "user_kcal_target", "generated_kcal", "estimated_cost", "cost_ok", "macros_ok", "diversity_summary"]
    }
  end

  # Schéma pour une recette individuelle
  def recipe_schema
    {
      type: "OBJECT",
      properties: {
        "name" => { type: "STRING", description: "Nom concis de la recette en français." },
        "preparation_time" => { type: "NUMBER", description: "Temps de préparation en minutes." },
        "kcal" => { type: "NUMBER", description: "Calories estimées pour une portion." },
        "cost" => { type: "NUMBER", description: "Coût estimé du repas en euros." },
        "ingredients" => {
          type: "ARRAY",
          items: { type: "STRING" },
          description: "Liste des 5 ingrédients principaux nécessaires (en français)."
        }
      },
      required: ["name", "preparation_time", "kcal", "ingredients"]
    }
  end

  # Gère l'appel HTTP POST à l'API Gemini avec backoff exponentiel
  def call_gemini_api(prompt, schema)
    uri = URI.parse("#{GEMINI_API_URL}?key=#{API_KEY}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    # Désactivation de la vérification SSL
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    payload = {
      contents: [{ parts: [{ text: prompt }] }],
      config: {
        system_instruction: system_prompt,
        response_mime_type: "application/json",
        response_schema: schema
      }
    }

    headers = { 'Content-Type' => 'application/json' }

    (1..MAX_RETRIES).each do |attempt|
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = payload.to_json

      begin
        response = http.request(request)

        if response.is_a?(Net::HTTPSuccess)
          return JSON.parse(response.body)
        elsif response.code.to_i == 429 && attempt < MAX_RETRIES
          sleep_time = 2**attempt
          Rails.logger.warn "Rate limit atteint (429). Tentative de nouvelle requête dans #{sleep_time} secondes..."
          sleep(sleep_time)
        else
          # Capture l'erreur HTTP 400/500/etc.
          Rails.logger.error "Erreur HTTP #{response.code}: #{response.body}"
          return nil
        end
      rescue Errno::ECONNREFUSED, Net::ReadTimeout, Errno::EHOSTUNREACH => e
        Rails.logger.error "Erreur de connexion (tentative #{attempt}): #{e.message}"
        return nil if attempt == MAX_RETRIES
        sleep(2**attempt)
      end
    end
    nil
  end
end
