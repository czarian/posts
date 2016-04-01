Rails.application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'
  root 'homes#show'

  devise_for :users
  resources :posts
  resources :comments, only: [:show, :create]
end
