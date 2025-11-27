Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "home#index"

  resource :profile, only: [:show, :edit, :update]
  get 'who_you_are', to: 'profiles#edit', as: :who_you_are

  post 'meal_plans/generate', to: 'meal_plans#generate', as: :meal_plans_generate

  resources :recipes, only: [:index, :show, :destroy, :new, :create]

  get "planner", to: "pages#planner"

  get "up" => "rails/health#show", as: :rails_health_check
end
