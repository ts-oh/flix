Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do
    resources :reviews
    resources :favorites, only: %i[create destroy]
  end

  resources :users
  get 'signup' => 'users#new'

  resources :sessions, only: %i[new create destroy]
  get 'signin' => 'sessions#new'
end
