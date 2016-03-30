Rails.application.routes.draw do


  root 'homes#show'

  devise_for :users
  resources :posts
  resources :comments, only: [:show, :create]
end
