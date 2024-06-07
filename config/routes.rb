Rails.application.routes.draw do
  get 'auth/login', to: 'auth#login'
  post 'auth/login', to: 'auth#login'
  get 'auth/logout', to: 'auth#logout'



  resources :users
  resources :profiles

  get "up" => "rails/health#show", as: :rails_health_check
end
