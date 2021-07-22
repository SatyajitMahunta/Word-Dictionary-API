Rails.application.routes.draw do
  #get "welcome", to: "welcome#index"
  root to: "welcome#index"

  get '/dict', to: 'dictionary#create'

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
