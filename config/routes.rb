Rails.application.routes.draw do
  mount RailsIcons::Engine, at: '/rails_icons'

  root "sessions#new"
  get "logout" => "sessions#destroy", as: :logout 
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"

  resources :users
  resources :sessions
  resources :pages, only: [:index]
end
