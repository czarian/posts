Rails.application.routes.draw do


  post '/rate' => 'rater#create', :as => 'rate'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  root 'homes#show'

  devise_for :users

  resources :users, :only => [] do
    member do
      get :posts
    end
  end

  resources :posts do
    collection do
      post :import
    end
  end
  resources :comments, only: [:show, :create]
end
