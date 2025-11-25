Rails.application.routes.draw do
  get 'recipes/index'
  get 'recipes/show'
  get "planner", to: "pages#planner"
  devise_for :users
  root to: "pages#home"

  post 'meal_plans/generate', to: 'meal_plans#generate', as: :meal_plans_generate
  get "up" => "rails/health#show", as: :rails_health_check

  resources :recipes, only: [:index, :show]

end
