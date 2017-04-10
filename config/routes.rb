Rails.application.routes.draw do

  root                 to: 'users#home'

  # User routes
  post   '/users',          to: 'users#create'
  get    '/users/new',      to: 'users#new',    as: 'new_user'
  get    '/users/:id/edit', to: 'users#edit',   as: 'edit_user'
  get    '/users/:id',      to: 'users#show',   as: 'user'
  patch  '/users/:id',      to: 'users#update', as: 'update_user'
  delete '/users/:id',      to: 'users#destroy'

  # Entry routes
  get    '/entries',                         to: 'entries#index'
  post   '/entries',                         to: 'entries#create'
  get    '/users/:user_id/entries/new',      to: 'entries#new',     as: 'new_entry'
  get    '/users/:user_id/entries/:id/edit', to: 'entries#edit',    as: 'edit_entry'
  get    '/users/:user_id/entries/:id',      to: 'entries#show',    as: 'show_entry'
  patch  '/entries/:id',                     to: 'entries#update',  as: 'update_entry'
  delete '/entries/:id',                     to: 'entries#destroy', as: 'delete_entry'


  # Session routes
  get     '/login',    to: 'sessions#new'
  post    '/login',    to: 'sessions#create'
  get     '/logout',   to: 'sessions#destroy'
  delete  '/logout',   to: 'sessions#destroy'

  # match "*path", to: 'application#page_not_found', via: :all

end
