Rails.application.routes.draw do
  get "sign_in", to: "sessions#new", as: :sign_in
  post "sign_in", to: "sessions#create"
  get "sign_up", to: "registrations#new", as: :sign_up
  post "sign_up", to: "registrations#create"
  delete "sign_out", to: "sessions#destroy", as: :sign_out

  resources :artists, only: [:show] do
    resources :tracks, only: [:index]
  end

  resources :albums, only: [:show] do
    patch :play, on: :member
  end

  resource :live_station, only: [:show, :update, :edit, :new, :create] do
    patch :start, on: :member
    patch :stop, on: :member

    resources :tracks, only: [:create, :destroy], module: :live_station do
      post :play, on: :member
    end
  end

  get "search", to: "search#index", as: :search

  root "home#index"
end
