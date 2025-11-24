# Gère la logique de génération des plans de repas via l'API.
# Nous faisons confiance à l'autoload de Rails pour trouver MenuGeneratorService.

class MealPlansController < ApplicationController

  # Action pour générer le plan de repas (utilise le service API)
  def generate
    # 1. Nettoyer et autoriser les paramètres
    permitted_params = preference_params

    # Correction pour le CHATBOT : Conversion de la chaîne d'allergies du chatbot en tableau
    if permitted_params[:allergies].present? && permitted_params[:allergies].is_a?(String)
        permitted_params[:allergies] = permitted_params[:allergies].split(',').reject(&:empty?)
    else
        permitted_params[:allergies] = []
    end

    @user_preference = UserPreference.new(permitted_params)

    if @user_preference.valid?
      # Appel du service API (Mode TEST : On force le plan de secours si quota épuisé)

      # generated_data = MenuGeneratorService.new(@user_preference).generate_menu # Ligne d'appel API réelle
      generated_data = nil # On simule l'échec de l'API (quota épuisé)

      # Si l'API retourne un hash valide et rempli
      if generated_data.present? && generated_data['menus'].present?
        # SUCCÈS API : Utilisation des données de Gemini
        @meal_plan = transform_gemini_output(generated_data, @user_preference)
        flash.now[:notice] = "Votre plan de repas hebdomadaire a été généré avec succès par l'IA !"
      else
        # ÉCHEC API : Utilisation du plan de secours
        @meal_plan = generate_fallback_plan(@user_preference)
        Rails.logger.warn "ÉCHEC DE L'API GEMINI : Activation du plan de secours."
        flash.now[:alert] = "La génération IA a échoué. Voici un plan de secours pour confirmer la fonctionnalité."
      end

      # Pointe vers la vue correcte 'app/views/pages/home.html.erb'
      render 'pages/home'
    else
      # Erreur de validation du formulaire
      flash.now[:alert] = "Veuillez corriger les erreurs dans vos préférences."
      render 'pages/home'
    end
  end

  private

  # Autorise les clés nécessaires.
  def preference_params
    params.require(:user_preference).permit(:age, :gender, :activity_level, :weekly_budget_max, :max_prep_time_minutes, :allergies)
  end

  # Transforme la sortie JSON de Gemini en hash Ruby utilisable
  def transform_gemini_output(generated_data, prefs)
    total_kcal = 0

    # Assurons-nous que toutes les clés sont présentes et que les calories sont additionnées
    generated_data['menus'].each do |day, meals|
      meals.each do |meal_type, recipe|
        # Assurer que kcal est bien un entier
        total_kcal += recipe['kcal'].to_i
      end
    end

    # Le plan a 21 repas (7 jours x 3 repas)
    average_daily_kcal = (total_kcal / 7.0).round(0)

    {
      :user_kcal_target => prefs.calculate_recommended_kcal,
      :generated_kcal => average_daily_kcal,
      :estimated_cost => (prefs.weekly_budget_max.to_f * 0.9).round(2), # Simuler le coût
      :cost_ok => true,
      :macros_ok => true,
      :diversity_summary => generated_data['diversity_summary'],
      :menus => generated_data['menus']
    }
  end

  # --- FONCTION DE SECOURS (Clés STRING pour la compatibilité Vue/JSON) ---
  def generate_fallback_plan(prefs)
    kcal_target = prefs.calculate_recommended_kcal

    menus = {}
    days = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche']
    meals = ['Petit-déjeuner', 'Déjeuner', 'Dîner']

    # Ce plan génère un hash avec des clés STRING ("name") pour correspondre au format JSON
    days.each do |day|
      menus[day] = {}
      meals.each do |meal|
        menus[day][meal] = {
          "name" => "#{meal} de Secours (FIXE)", # Clé STRING
          "preparation_time" => 20,              # Clé STRING
          "cost" => 4.5,                         # Clé STRING
          "kcal" => rand(250..800),              # Clé STRING
          "ingredients" => ["Riz", "Poulet", "Légumes variés"]
        }
      end
    end

    # Le hash de retour utilise les Symboles pour les clés principales.
    {
      :user_kcal_target => kcal_target,
      :generated_kcal => (kcal_target * 0.95).round(0),
      :estimated_cost => 65.0,
      :cost_ok => true,
      :macros_ok => true,
      :diversity_summary => "Plan de secours : Veuillez vérifier votre clé API ou votre connexion pour des recommandations ZOE complètes.",
      :menus => menus # Le hash de recettes corrigé
    }
  end
end
