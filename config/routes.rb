Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root "welcome#index"
  get '/register', to: 'users#new', as: 'register_user'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'dashboard#show'

  resources :users, only: [:create]

  resources :discover, only: [:index]

  resources :movies, only: [:index, :show] do
    resources :viewing_parties, only: [:new, :create, :show]
    resources :similar, only: [:index]
  end
end
