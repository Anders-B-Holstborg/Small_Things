Rails.application.routes.draw do
  devise_for :users

  resources :activities
  resources :categories do
    resources :user_categories, only: [ :new, :create, :edit, :update, :index, :show ]
  end

  resources :bookings do
    resources :reviews, only: [ :new, :create ]
  end

  get 'users', to: 'users#index'

  get 'dashboard', to: 'users#dashboard'
  root to: 'users#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
