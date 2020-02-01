Rails.application.routes.draw do
  devise_for :users

  resources :activities
  resources :categories
  resources :category_users
  resources :reviews
  resources :bookings
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
