Rails.application.routes.draw do
  root "static_pages#top"
  resource :profile, only: %i[show edit update]
  resources :tasks
  resources :users, only: %i[new create]
  resources :boards, only: %i[index new create show edit destroy update] do
    resources :comments, only: %i[create edit update destroy], shallow: true
    collection do
      get :cheers
    end
  end
  resource :streak, only: %i[show]
  resources :trophies, only: %i[index]
  resources :cheers, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  get "dashboard", to: "dashboard#index"
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy", as: :logout
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/pages/*id" => "pages#show", as: :page, format: false
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # Defines the root path route ("/")
  # root "posts#index"
end
