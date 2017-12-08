Rails.application.routes.draw do

  get 'shops/test', to: 'shops#test'

  resources :shops, only: [:show]

  namespace :api do
    get '/webhook', to: 'webhook#verify', as: 'verify'
    post '/webhook', to: 'webhook#handle_event', as: 'handle_event'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
