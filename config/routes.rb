Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post '/scan', to: 'house_foods#scan'
  resources :shopping_lists, only: [:show]
  resources :house_foods do
    member do
      patch :eat
      patch :add
    end
  end
  resources :foods, only: [] do
    resources :house_foods, only: :create
  end
  resources :items, only: %i[destroy create new]
  # Defines the root path route ("/")
  # root "articles#index"
end
