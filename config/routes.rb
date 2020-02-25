Rails.application.routes.draw do
  devise_for :users

  resources :activities do
    member do
      post :approve
    end
  end
  get 'custom_activities', to: 'activities#custom_activities'
  resources :categories do
    resources :user_categories, only: [ :edit, :update, :index, :show ]
  end
  resources :user_categories, only: [ :new, :create ]
  resources :bookings do
     member do
      get 'accepted_activity', to: 'bookings#accepted_activity'
    end
    resources :reviews, only: [ :new, :create ]
  end

  get 'dashboard', to: 'users#dashboard'
  root to: 'users#dashboard'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

