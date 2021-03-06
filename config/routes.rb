Rails.application.routes.draw do

  root                        to: 'users#home'

  # User routes
  post   '/users',            to: 'users#create'
  get    '/users/new',        to: 'users#new',        as: 'new_user'
  get    '/users/:id/edit',   to: 'users#edit',       as: 'edit_user'
  get    '/users/:id',        to: 'users#show',       as: 'user'
  patch  '/users/:id',        to: 'users#update',     as: 'update_user'
  delete '/users/:id',        to: 'users#destroy'

  # Entry routes
  get    '/entries',          to: 'entries#index'
  post   '/entries',          to: 'entries#create'
  get    '/entries/new',      to: 'entries#new',      as: 'new_entry'
  get    '/entries/:id/edit', to: 'entries#edit',     as: 'edit_entry'
  get    '/entries/:id',      to: 'entries#show',     as: 'show_entry'
  patch  '/entries/:id',      to: 'entries#update',   as: 'update_entry'
  delete '/entries/:id',      to: 'entries#destroy',  as: 'delete_entry'

  # Comments
  get    '/comments',         to: 'comments#index'
  get    '/comments/new',     to: 'comments#new',     as: 'new_comment'
  get    '/comments/:id',     to: 'comments#show',    as: 'comment'
  post   '/comments',         to: 'comments#create'
  delete '/comments/:id',     to: 'comments#destroy', as: 'delete_comment'

  # Session routes
  get     '/login',           to: 'sessions#new'
  post    '/login',           to: 'sessions#create'
  get     '/logout',          to: 'sessions#destroy'
  delete  '/logout',          to: 'sessions#destroy'

  # Search forecast endpoints
  get     '/potato',          to: 'forecasts#by_geolocation'
  get     '/eggplant',        to: 'forecasts#by_search'

  # match "*path", to: 'application#page_not_found', via: :all

end
