Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "about"
  get "search" => "searches#search"
  resources :users, only: [:show, :create, :index, :edit, :update]
  resources :devise, only:[:new ,:edit]
  resources :books, only: [:create, :index, :show, :destroy, :update, :edit] do
  resources :book_comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
  end
   resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    member do
    get :followings, :followers
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
