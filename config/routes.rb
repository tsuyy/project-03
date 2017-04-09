Rails.application.routes.draw do

  root                 to: 'users#home'

  # User routes
  resources :users

  # Session routes
  get     '/login',    to: 'sessions#new'
  post    '/login',    to: 'sessions#create'
  get     '/logout',   to: 'sessions#destroy'
  delete  '/logout',   to: 'sessions#destroy'

  # match "*path", to: 'application#page_not_found', via: :all

end
