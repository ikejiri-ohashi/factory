Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    get '/users/:id', to: 'users#show', as: 'user'
  end
  root to: "jobs#index"
  resources :jobs, only: [:new, :create, :show] do
    resources :comments, only: [:new, :create]
    resources :favorites, only: [:create, :destroy]
  end
  resources :company_profiles, only: [:new, :create, :edit, :update]
end
