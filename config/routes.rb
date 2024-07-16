Rails.application.routes.draw do
post "auth/register", to: "authentication#register"
  post "auth/login", to: "authentication#login"
  resources :users, only: [:index, :show, :create]
end
