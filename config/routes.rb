Rails.application.routes.draw do
  resources :users
  get "signup" => "users#new"
  resource :session
  get "signin" => "sessions#new"

  root "movies#index"
  resources :movies do
    resources :reviews
  end
end
