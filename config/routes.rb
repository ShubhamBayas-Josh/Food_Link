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
  # post "/login", to: "auth#login"

  namespace :api do
    namespace :v1 do
      resources :users, only: [ :index, :show, :create, :update, :destroy ]
<<<<<<< Updated upstream
      resources :food_claims, only: [ :index, :show, :create, :update, :destroy ]
      resources :food_transaction, only: [ :index, :show, :create, :update, :destroy ]
      resources :feedbacks, only: [ :index, :show, :create, :update, :destroy ]
      resources :admins, only: [ :index, :show, :create, :update, :destroy ]
      post "/auth/login", to: "authentication#login"
    end
  end


=======
<<<<<<< Updated upstream
    end
  end

=======
      resources :food_claims, only: [ :index, :show, :create, :update, :destroy ]
      resources :food_transaction, only: [ :index, :show, :create, :update, :destroy ]
      resources :feedbacks, only: [ :index, :show, :create, :update, :destroy ]
      resources :admins, only: [ :index, :show, :create, :update, :destroy ]
      # post "/auth/login", to: "authentication#login"
    end
  end

  resources :users, only: [ :create ]
  post "/login", to: "users#login"

  resources :food_transactions, only: [ :create, :index, :update, :destroy ]
  resources :food_claims, only: [ :create, :index, :update ]
  resources :feedbacks, only: [ :create, :index ]
  resources :notifications, only: [ :index ]


>>>>>>> Stashed changes
>>>>>>> Stashed changes
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
