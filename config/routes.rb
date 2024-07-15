Rails.application.routes.draw do

  post "auth/login", to: "authentication#login"
  resources :users, only: [:index, :show, :create]
end
