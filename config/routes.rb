Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Home
  root to: "home#index"

  # Chatbot
  get  "assistant",        to: "assistant#show",  as: :assistant
  post "assistant/talk",   to: "assistant#talk",  as: :assistant_talk
  post "assistant/reset",  to: "assistant#reset", as: :reset_chat

  # Profile (Mahé)
  resource :profile, only: [:show, :edit, :update]
  get 'who_you_are', to: 'profiles#edit', as: :who_you_are

  # AI meal plan (old feature – kept for now so you don't break teammates' work)
  post 'meal_plans/generate', to: 'meal_plans#generate', as: :meal_plans_generate

  # Recipes = cookbook
  resources :recipes, only: [:index, :show, :destroy]

  # Old planner page (if still used)
  get "planner", to: "pages#planner"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
