Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'devise/passwords' }
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy] 
      resources :likes, only: [:create]
    end
  end
end
