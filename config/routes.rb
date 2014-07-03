Rails.application.routes.draw do
  root to:'static_pages#home'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :comments, only: [:create, :destroy]

  match '/signup',to:  'users#new', via: 'get'
  match '/signin',to:  'sessions#new', via: 'get'
  match '/signin',to:  'sessions#destroy', via: 'delete'

  get 'static_pages/home'
  get 'static_pages/about'

end
