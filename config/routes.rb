Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "/home/about" => "homes#about", as: "about"
  resources :users, only: [:show, :create, :index, :edit, :update]
  resources :devise, only:[:new ,:edit]
  resources :books, only: [:create, :index, :show, :destroy, :update, :edit] do
  resources :book_comments, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
