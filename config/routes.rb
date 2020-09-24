Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :maps, only: [:index]
  resources :users, only: [:show, :edit, :update, :destroy] do
    collection do
      get 'user_favorite'
    end
  end
  resources :groups, except: :index
  resources :posts do
    collection do
      get 'search'
      get 'again_search'
      get 'post_all_page'
      get 'no_nreleased'
    end
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end
