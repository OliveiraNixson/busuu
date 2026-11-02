Rails.application.routes.draw do
  get "languages/index"
  mount RailsIcons::Engine, at: "/rails_icons"
  root to: "sessions#new"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :pages, only: [ :index, :new, :create ]
  resources :sessions, only: [ :new, :create ] do
    collection do
      get :logout
    end
  end
  resources :users, except: [ :show ] do
    collection do
      get :languages
    end
  end
  resources :languages do
    resources :courses, only: [:edit, :update]
  end
  resources :settings, only: [ :index ]
  resources :courses, only: [ :index, :show, :new, :create ]
end
