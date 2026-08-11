Rails.application.routes.draw do
  mount RailsIcons::Engine, at: '/rails_icons'
  root "pages#home"

  resources :pages, only: [:index]
end
