Rails.application.routes.draw do
  root to: "home#index"

  devise_for :admins, controllers: {
    registrations: "admins/registrations"
  }
  resources :activities, only: [ :index ]  # For ActivitiesController
  resources :admins do
    collection do
      get "reports" # This will link to the reports page
    end
  end

  resources :users
  resources :donations
  post "/users/approve/:id", to: "users#approve_user", as: "approve_user"

  # Rails.application.routes.draw do

  #   match "/api/v1/*path", to: "application#preflight", via: [ :options ]
  # end


  # namespace :api do
  #   namespace :v1 do
  #     resources :users, only: [ :index, :show, :create, :update, :destroy ]
  #     match "users", to: "users#options", via: :options

  #     get "/*a", to: "application#not_found"
  #   end
  # end

  # namespace :api do
  #   post "/signup", to: "users#create"
  # end



  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index, :show, :create, :update, :destroy ]
      resources :food_transactions, only: [ :index, :show, :create, :update, :destroy ]
      resources :food_claims, only: [ :index, :show, :create, :update, :destroy ]
      resources :feedbacks, only: [ :index, :show, :create, :update, :destroy ]
      resources :admins, only: [ :index, :show, :create, :update, :destroy ]
      post "/auth/login", to: "authentication#login"
      post "/auth/signup", to: "authentication#signup"
    end
  end





  resources :orders
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
