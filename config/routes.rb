Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations"}
  devise_scope :user do
    root "users/sessions#new"
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :users, :only => [:show]
  resources :posts
  resources :posts do
    resource :favorites, only: [:create, :destroy]
 end
end
