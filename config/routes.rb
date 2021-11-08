Rails.application.routes.draw do
  root to: "jobs#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  get '/pre_recommend' => 'jobs#pre_recommend', as: 'jobs_pre_recommend'
  get '/back_index' => 'jobs#back_index', as: 'jobs_back_index'
  post '/recommend' => 'jobs#recommend', as: 'jobs_recommend'
  resources :jobs, only: [:new, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
    post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
    delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
    resources :contracts, only: [:create]
    resources :requests, only: [:create, :destroy]
  end
  resources :company_profiles, only: [:new, :create, :edit, :update]
  resources :users, only: [:show] do
    post 'follow/:id' => 'follows#create', as: 'create_follow'
    delete 'follow/:id' => 'follows#destroy', as: 'destroy_follow'
    post 'request_from_user/:id' => 'requests#create_from_user', as: 'create_from_user'
    get '/select_jobs/:id' => 'users#select_jobs', as: 'select_jobs'
    get '/select_favorites/:id' => 'users#select_favorites', as: 'select_favorites'
    get '/select_contracts/:id' => 'users#select_contracts', as: 'select_contracts'
    get '/select_accepts/:id' => 'users#select_accepts', as: 'select_accepts'
  end
end
