Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
    resources :house_foods
  # Defines the root path route ("/")
  # root "articles#index"
end
