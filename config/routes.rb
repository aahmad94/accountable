Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#root"
  
  namespace :api, defaults: { format: :json } do
    # auth
    resources :users, only: [:create, :index]
    resource :session, only: [:create, :destroy]
  end
  
  # ---------- users_search ----------
  get '/api/users/search/:query' => 'api/users#search',
     as: 'api_users_search',
     defaults: { format: :json }

end
