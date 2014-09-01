Rails.application.routes.draw do
  resources :genres

  resources :favorites

  resources :users
  get "signup" => "users#new"
  resource :session
  get "signin" => "sessions#new"

  root "movies#index"

  get "movies/filter/:scope" => "movies#index", :as => :filtered_movies

  resources :movies do
    resources :reviews
    resources :favorites
  end
end
