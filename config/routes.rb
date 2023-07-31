Rails.application.routes.draw do
  root 'movies#index'

  get 'movies/filter/:filter' => 'movies#index', as: :filtered_movies

  resources :movies do
    resources :reviews
    resources :favorites, only: %i[create destroy]
  end

  resources :users
  get 'signup' => 'users#new'

  resources :sessions, only: %i[new create destroy]
  get 'signin' => 'sessions#new'

  resources :genres
end
