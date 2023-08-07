Rails.application.routes.draw do
  devise_for :users

  root 'homes#index'

  resources :users, only: [:show]

  resources :animations, only: [:index, :show,] do
    resources :favorites, only: [:create, :destroy]
    resources :reviews, only: [:index, :new, :create]
    collection do
      get 'search_results'
    end
  end
end
