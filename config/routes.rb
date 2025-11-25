Rails.application.routes.draw do
  get 'profiles/edit'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "pages#home"

  resource :profile, only: [:show, :edit, :update]
  get 'who_you_are', to: 'profiles#edit', as: :who_you_are

  post 'meal_plans/generate', to: 'meal_plans#generate', as: :meal_plans_generate

  resources :recipes, only: [:index, :show]
  get 'recipes/index'
  get 'recipes/show'
  get "planner", to: "pages#planner"
  get "up" => "rails/health#show", as: :rails_health_check

end
