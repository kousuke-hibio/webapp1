Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  post 'posts/new'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'toppages/index'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
    end 
    collection do
      get 'search'
    end 
    member do 
      get :likes
    end
  end 

  resources :posts do
    resources :comments, only: [:create]
  end 
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

end
