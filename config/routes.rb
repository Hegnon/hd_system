Rails.application.routes.draw do
  get 'auth/login'
  post 'auth/login', to: 'auth#login'

  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  post 'users', to: 'users#create'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  get 'profiles', to: 'profiles#index'
  get 'profiles/:id', to: 'profiles#show'
  post 'profiles', to: 'profiles#create'
  put 'profiles/:id', to: 'profiles#update'
  delete 'profiles/:id', to: 'profiles#destroy'


  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
