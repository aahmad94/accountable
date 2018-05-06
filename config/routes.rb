Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#root"
  
  namespace :api, defaults: { format: :json } do
    # auth
    resources :users, only: [:create, :index]
    resources :groups, only: [:create, :index]
    resource :challenges, only: [:create]

    match '/session', :controller => 'sessions', :action => 'create', :via => :options
    match '/session', :controller => 'sessions', :action => 'destroy', :via => :delete
  end
  
  # ---------- users_search ----------
  get '/api/users/search/:query' => 'api/users#search',
    as: 'api_users_search',
    defaults: { format: :json }
  
  get '/api/groups/:id/challenges/' => 'api/groups#challenges',
    as: 'api_group_challenges',
    defaults: { format: :json }
  
  # ---------- challenges ----------
  patch '/api/challenges/:id' => 'api/challenges#update'

  # ---------- groups ----------
  # post '/api/groups/initialize' => 'api/groups#initialize',
  #   as: 'api_groups_initialize',
  #   defaults: { format: :json }

end
