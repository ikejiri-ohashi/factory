Rails.application.routes.draw do
  root to: "jobs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :jobs, only: [:new, :create, :show, :destroy] do
    resources :comments, only: [:new, :create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :contracts, only: [:create]
  end
  resources :company_profiles, only: [:new, :create, :edit, :update]
  resources :users, only: [:show] do
    resources :follows, only:[:create, :destroy]
  end
end
