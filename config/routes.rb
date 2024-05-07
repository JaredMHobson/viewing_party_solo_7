Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  resources :users, only: [:show, :create] do
    member do
      # get 'discover'
      resources :discover, only: [:index]
      resources :movies, only: [:index]
    end
  end
end
