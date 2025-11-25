Rails.application.routes.draw do
  get 'recipes/index'
  get 'recipes/show'
  devise_for :users
  root to: "pages#home"

  post 'meal_plans/generate', to: 'meal_plans#generate', as: :meal_plans_generate
  get "up" => "rails/health#show", as: :rails_health_check


  # Routes pour Mahé - ProfileController
 resource :profile, only: [:show, :edit, :update]
  get 'who_you_are', to: 'profiles#edit', as: :who_you_are
  resources :recipes, only: [:index, :show]

end
