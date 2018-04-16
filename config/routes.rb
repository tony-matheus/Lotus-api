Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations:  'overrides/registrations'
    # sessions: 'overrides/sessions'
  }
  root to: 'application#home'
  # namespace :api, constraints: { subdomain: 'api'}, path: "/" do

  #user avatar
  post '/user/avatar' => 'overrides/registrations#user_avatar'
  #informations
  post '/informations' => 'informations#create'
  post '/informations/update' => 'informations#update'
  get '/informations' => 'informations#show'
  #store
  post '/store/create' => 'stores#create'
  post '/store/update' => 'stores#update'
  get '/store/show' => 'stores#show'
  get '/store/stores' => 'stores#show_stores'
  get '/store/select' => 'stores#select_stores'
  #services
  post '/service/create' => 'services#create_service'
  post '/service/update' => 'services#update'
  get '/service/show' => 'services#show'
  delete '/service/delete' => 'services#destroy'
  #products
  post '/product/create' => 'services#create_products'
  post '/product/update' => 'services#update_products'
  get '/product/show' => 'services#show_all_products'
  delete '/product/delete' => 'services#destroy_products'
  #images
  post '/store/image' => 'stores#save_images'
  post '/service/image' => 'services#' 

end
