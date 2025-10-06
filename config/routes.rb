Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/login", to: "auth#login"
      post "/register", to: "auth#register"
      delete "/logout", to: "auth#logout"

      resources :home
      resources :categories

      resources :accounts
      resources :transactions

      # resources :users, only: [:create, :show, :update, :destroy]
    end
  end
end
