Rails.application.routes.draw do
  devise_for :users
  root to: "jobs#index"
  resources :jobs, only: [:new, :create, :show] do
    resources :comments, only: [:new, :create]
  end
end
