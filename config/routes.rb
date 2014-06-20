Rails.application.routes.draw do
  root to:'static_pages#home'

  resources :users

  match '/signup',to:  'users#new', via: 'get'
  get 'static_pages/home'
  get 'static_pages/about'

end
