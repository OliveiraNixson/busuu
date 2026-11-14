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
  post :update_language
    collection do
      get :languages
    end
  end
  resources :languages, except: [ :show ] do
    resources :courses, only: [ :new, :create, :edit, :update, :index ]
  end
  resources :settings, only: [ :index ]
end
