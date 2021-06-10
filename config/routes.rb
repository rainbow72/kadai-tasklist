Rails.application.routes.draw do
  get 'toppages/index'
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :tasks
end
