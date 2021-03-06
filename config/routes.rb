Rails.application.routes.draw do
  get 'hello_world', to: 'hello_world#index'
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
  get '/user_research' => 'jobs#user_research', as: 'user_research'
  resources :jobs, only: [:new, :create, :show, :destroy, :edit, :update] do
    resources :comments, only: [:create, :destroy]
    post 'favorite/:id' => 'favorites#create', as: 'create_favorite'
    delete 'favorite/:id' => 'favorites#destroy', as: 'destroy_favorite'
    resources :contracts, only: [:create, :destroy]
    resources :requests, only: [:create, :destroy]
    get '/back_info' => 'jobs#back_info', as: 'jobs_back_info'
  end
  resources :users, only: [:show] do
    resources :company_profiles, only: [:new, :create, :edit, :update, :show]
    post 'follow/:id' => 'follows#create', as: 'create_follow'
    delete 'follow/:id' => 'follows#destroy', as: 'destroy_follow'
    post 'request_from_user/:id' => 'requests#create_from_user', as: 'create_from_user'
    delete 'destroy_from_user/:id' => 'requests#destroy_from_user', as: 'destroy_from_user'
    get '/select_jobs/:id' => 'users#select_jobs', as: 'select_jobs'
    get '/select_favorites/:id' => 'users#select_favorites', as: 'select_favorites'
    get '/select_contracts/:id' => 'users#select_contracts', as: 'select_contracts'
    get '/select_accepts/:id' => 'users#select_accepts', as: 'select_accepts'
    get '/user_info/:id' => 'users#user_info', as: 'user_info'
    get '/user_follow/:id' => 'users#user_follow', as: 'user_follow'
    get '/user_follower/:id' => 'users#user_follower', as: 'user_follower'
  end
end
