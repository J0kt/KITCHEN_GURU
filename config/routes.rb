Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  post 'meal_plans/generate', to: 'meal_plans#generate', as: :meal_plans_generate
  get "up" => "rails/health#show", as: :rails_health_check
  
end
