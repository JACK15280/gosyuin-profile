Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :maps, only: [:index]
  resources :users, only: [:show, :edit, :update, :destroy]
  resources :groups, except: :index
  resources :posts
end
