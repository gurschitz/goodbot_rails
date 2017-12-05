Rails.application.routes.draw do

  resources :shops, only: [:show]

  namespace :api do
    get '/webhook', to: 'webhook#verify', as: 'verify'
    post '/webhook', to: 'webhook#handle_message_connection', as: 'handle_message_connection'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
