Rails.application.routes.draw do
  mount RailsIcons::Engine, at: "/rails_icons"
  root to: "sessions#new"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :pages, only: [ :index, :new, :create ]
  resources :sessions, only: [ :new, :create ]
  resources :users, except: [ :show ]
end
