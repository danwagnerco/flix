Rails.application.routes.draw do
  get "signup" => "users#new"
  resources :users
  get "signin" => "sessions#new"
  resource :session

  root "movies#index"
  resources :movies do
    resources :reviews
  end
end
