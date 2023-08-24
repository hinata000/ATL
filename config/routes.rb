Rails.application.routes.draw do
  devise_for :users

  root 'homes#index'

  resources :users, only: [:show]

  resources :animations, only: [:index, :show,] do
    resources :tier_lists, only: [:create, :new, :edit, :update, :destroy]
    collection do
      get 'search_results'
    end
  end
end
