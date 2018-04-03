Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations:  'overrides/registrations'
  }
  root to: 'application#home'
  # namespace :api, constraints: { subdomain: 'api'}, path: "/" do
  #informations
  post '/informations' => 'informations#create'
  post '/informations/update' => 'informations#update'
  get '/informations' => 'informations#show'
  #store
  post '/store/create' => 'stores#create'
  post '/store/update' => 'store#update'
  get '/store/show' => 'store#show'
  get '/store/stores' => 'store#show_stores'
  get '/store/select' => 'store#select_stores'
  #services
  post '/service/create' => 'services#create_service'
  post '/service/update' => 'service#update'
  get '/service/show' => 'service#show'
  delete '/service/delete' => 'service#destroy'
  #products
  post '/product/create' => 'service#create_products'
  post '/product/update' => 'service#update_products'
  get '/product/show' => 'service#show_all_products'
  delete '/product/delete' => 'service#destroy_products'


end
