Rails.application.routes.draw do

  root to: 'pages#index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  resources :pages, only: [:index]
end
