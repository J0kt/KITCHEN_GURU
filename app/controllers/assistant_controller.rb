require "net/http"
require "uri"
require "json"

class AssistantController < ApplicationController
  before_action :authenticate_user!

  def show
    session[:assistant_messages] ||= []
    @messages = session[:assistant_messages]

    # We only show "Save recipe" if the last message comes from the assistant
    last_msg = @messages.last
    @can_save_recipe = last_msg.present? && last_msg["role"] == "assistant"
  end

  def talk
    user_message = params[:message].to_s.strip

    if user_message.blank?
      redirect_to assistant_path, alert: "Please write a message first." and return
    end

    # 1. Get history from session (or init)
    history = session[:assistant_messages] ||= []

    # 2. Add the new user message into our history
    history << { "role" => "user", "content" => user_message }

    # 3. System prompt
    system_prompt = <<~PROMPT
      You are KitchenGuru, an AI Chef and Nutritionist specialized in gut-health
      and anti-inflammatory cooking, inspired by ZOE Health principles.

      CORE ZOE-STYLE GUIDELINES:
      1. DIVERSITY:
         Help the user reach at least ~30 different plants per week
         (fruits, vegetables, whole grains, legumes, nuts, seeds, herbs, spices).
         Favour variety in your suggestions instead of always repeating the same foods.
      2. FAT QUALITY:
         Prioritize extra-virgin olive oil, avocado, nuts and seeds as main fat sources.
      3. AVOID:
         Limit ultra-processed foods and added sugars. Do not recommend them
         unless the user explicitly insists.

      CONVERSATION BEHAVIOUR:
      - Be efficient: do NOT ask too many clarification questions in a row.
      - If the user already gave meal type + preferences + ingredients,
        go directly to suggesting a recipe.
      - If something is missing, ask at most 1–2 short follow-up questions,
        then propose a recipe anyway.

      RECIPE FORMAT:
      When you give a full recipe, ALWAYS use this plain-text structure:

      Title:
      Meal type:
      Prep time (minutes):
      Cook time (minutes):
      Ingredients:
       item 1
       item 2
      Steps:



      Macros (approx per serving):
       Calories:
       Protein (g):
       Carbs (g):
       Fats (g):
       Fiber (g):

      Macros must be simple but realistic estimates.
    PROMPT

    # 4. Build a single conversation string from history
    conversation_text = history.map do |m|
      speaker = m["role"] == "assistant" ? "Assistant" : "User"
      "#{speaker}: #{m['content']}"
    end.join("\n\n")

    full_prompt = <<~FULL
      #{system_prompt}

      Here is the conversation so far between the user and KitchenGuru:

      #{conversation_text}

      Now answer as KitchenGuru to the LAST user message.
      If appropriate, give a full recipe using the RECIPE FORMAT.
    FULL

    # 5. Call RubyLLM with a single string
    chat = RubyLLM.chat
    response = chat.ask(full_prompt)

    assistant_text =
      if response.respond_to?(:content)
        response.content
      else
        response.to_s
      end

    # 6. Add assistant reply to history and save in session
    history << { "role" => "assistant", "content" => assistant_text }
    session[:assistant_messages] = history

    redirect_to assistant_path
  rescue StandardError => e
    Rails.logger.error("Assistant error: #{e.class} - #{e.message}")
    redirect_to assistant_path, alert: "Something went wrong talking to KitchenGuru."
  end

  def reset
    session[:assistant_messages] = []
    redirect_to assistant_path, notice: "Chat reset."
  end

  # NEW ACTION: save last AI recipe as a Recipe record
  def save
    history = session[:assistant_messages] || []
    last_assistant_msg = history.reverse.find { |m| m["role"] == "assistant" }

    if last_assistant_msg.blank?
      redirect_to assistant_path, alert: "There is no AI recipe to save yet." and return
    end

    recipe_attrs = build_recipe_from_ai(last_assistant_msg["content"])
    @recipe = current_user.recipes.new(recipe_attrs)

    @recipe.title


    uri = URI("https://api.openai.com/v1/images/generations")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE  # ⚠️ INSECURE – JUST FOR TESTING

    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "Bearer #{ENV['OPENAI_KEY']}"

    req.body = {
      model: "gpt-image-1",
      n: 1,
      quality: "low",
      size: "1536x1024",
      prompt: "High-quality food photography of: #{@recipe.title} #{@recipe.description} just show a picture of a the dish with no text "
    }.to_json

    res = http.request(req)


    # Parse JSON
    body = JSON.parse(res.body)

    # Get the base64 string
    b64_data = body.dig("data", 0, "b64_json")

    @recipe.image_data = b64_data

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "Recipe saved to your cookbook."
    else
      Rails.logger.error("Recipe save failed: #{@recipe.errors.full_messages.join(', ')}")
      redirect_to assistant_path, alert: "Could not save this recipe."
    end
  end

  private

  # Very simple parser based on the format we asked the AI to use
  def build_recipe_from_ai(text)
    title      = text[/^Title:\s*(.+)$/i, 1] || "KitchenGuru recipe"
    prep_min   = text[/^Prep time.*?:\s*(\d+)/i, 1]
    cook_min   = text[/^Cook time.*?:\s*(\d+)/i, 1]

    calories   = text[/Calories:\s*(\d+)/i, 1]
    proteins   = text[/Protein.*?:\s*(\d+)/i, 1]
    carbs      = text[/Carbs.*?:\s*(\d+)/i, 1]
    fats       = text[/Fats?.*?:\s*(\d+)/i, 1]
    fiber      = text[/Fiber.*?:\s*(\d+)/i, 1]

    text = text.sub("Macros (approx per serving):", "")
    text = text.sub("Calories: #{calories} kcal", "")
    text = text.sub("Protein: #{proteins} g", "")
    text = text.sub("Carbs: #{carbs} g", "")
    text = text.sub("Fats: #{fats} g", "")
    text = text.sub("Fiber: #{fiber} g", "")

    {
      title:       title,
      description: text,                      # full text used by your show view
      prep_time:   prep_min.to_i > 0 ? prep_min.to_i : nil,
      cook_time:   cook_min.to_i > 0 ? cook_min.to_i : nil,
      calories:    calories.present? ? calories.to_i : nil,
      proteins:    proteins.present? ? proteins.to_i : nil,
      carbs:       carbs.present? ? carbs.to_i : nil,
      fats:        fats.present? ? fats.to_i : nil,
      fiber:       fiber.present? ? fiber.to_i : nil,
      servings:    2                           # simple default
    }
  end
end
