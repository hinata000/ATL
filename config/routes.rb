Rails.application.routes.draw do
  root 'homes#index'

  resources :animations, only: [:index, :show,] do
    resources :favorites, only: [:create, :destroy]
    resources :reviews, only: [:index, :new, :create]
    collection do
      get 'search_results'
    end
  end
end
