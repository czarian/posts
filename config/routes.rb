Rails.application.routes.draw do


  get 'index/new'

  devise_for :users
  resources :posts
  resources :comments, only: [:show, :create]
end
