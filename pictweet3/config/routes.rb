Rails.application.routes.draw do
  devise_for :users
  root to: 'tweets#index'
  # resources :tweets, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :tweets

  resources :users, only: :show
end
