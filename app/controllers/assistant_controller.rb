class AssistantController < ApplicationController
  before_action :authenticate_user!

  def show
    session[:assistant_messages] ||= []
    @messages = session[:assistant_messages]
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

    # 3. System prompt (same spirit as before, just reused here)
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
      - item 1
      - item 2
      Steps:
      1.
      2.
      3.
      Macros (approx per serving):
      - Calories:
      - Protein (g):
      - Carbs (g):
      - Fats (g):
      - Fiber (g):

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

    # 5. Call RubyLLM with a single string (avoids the messages[] error)
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
end
