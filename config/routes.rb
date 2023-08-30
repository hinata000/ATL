Rails.application.routes.draw do
  devise_for :users

  root 'homes#index'

  resources :users, only: [:show]

  resources :animations, only: [:index, :show,] do
    resources :tier_lists, only: [:create, :new, :edit, :update, :destroy]
    resources :tier_list_entiers, only: [:create, :new, :edit, :update, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    collection do
      get 'search_results'
    end
  end
end
