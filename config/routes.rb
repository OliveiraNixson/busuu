Rails.application.routes.draw do
  root to: "sessions#new"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :pages, only: [ :index, :new, :create ]
  resources :sessions, only: [ :new, :create ]
  resources :users, except: [ :show ]
end
