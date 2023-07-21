Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do
    resources :reviews
  end

  resources :users
  get "signup" => "users#new"

  resources :sessions, only:[:new, :create, :destroy]
  get "signin" => "sessions#new"

end
