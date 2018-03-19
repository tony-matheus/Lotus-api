Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations:  'overrides/registrations'
  }
  root to: 'application#home'
  # namespace :api, constraints: { subdomain: 'api'}, path: "/" do
  post '/informations' => 'informations#create'
  post '/informations/update' => 'informations#update'

  post '/profile' => 'profile#create'
  get '/profile' => 'profile#profile'

end
