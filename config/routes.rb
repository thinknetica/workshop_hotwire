Rails.application.routes.draw do
  get "sign_in", to: "sessions#new", as: :sign_in
  post "sign_in", to: "sessions#create"
  get "sign_up", to: "registrations#new", as: :sign_up
  post "sign_up", to: "registrations#create"
  delete "sign_out", to: "sessions#destroy", as: :sign_out

  resources :artists, only: [:show]
  resources :albums, only: [:show] do
    patch :play, on: :member
  end

  resources :stations, only: [:show]
  resource :station, only: [:show, :update], as: :my_station

  root "home#index"
end
