Rails.application.routes.draw do
  devise_for :users

  root 'homes#index'

  resources :users, only: [:show]

  resources :animations, only: [:index, :show,] do
    resources :tier_lists, only: [:create, :edit, :new]
    collection do
      get 'search_results'
    end
  end
end
