Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :shopping_lists, only: [:show]
  resources :house_foods do
    member do
      patch :eat
    end
  end
  resources :foods, only: [] do
    resources :house_foods, only: :create
  end
  resources :items, only: %i[destroy create]
  # Defines the root path route ("/")
  # root "articles#index"
end
