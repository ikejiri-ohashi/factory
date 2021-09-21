Rails.application.routes.draw do
  root to: "jobs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    # get '/users/:id', to: 'users#show', as: 'user'
  end
  resources :jobs, only: [:new, :create, :show] do
    resources :comments, only: [:new, :create]
    resources :favorites, only: [:create, :destroy]
  end
  resources :company_profiles, only: [:new, :create, :edit, :update]
  resources :users, only: [:show] do
    resources :follows, only:[:create, :destroy]
  end
end
