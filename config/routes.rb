Rails.application.routes.draw do
  devise_for :users

  resources :activities
  resources :categories
  resources :category_users
  resources :reviews
  resources :bookings
  get 'dashboard', to: 'users#dashboard'
  root to: 'users#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
