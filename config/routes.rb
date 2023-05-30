Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "about", to: "pages#about"

  resources :venues do
    resources :bookings, only: %i[new create]
    resources :venue_offers, only: %i[create edit new update destroy]
    resources :favorite_venues, only: %i[create destroy] do
      member do
        post :toggle_favorite
      end
    end
    resources :reviews, only: %i[show index]
  end

  resources :users do
    resources :favorite_venues, only: %i[index]
  end

  resources :users, only: %i[show edit update]
  resources :bookings, only: %i[index show destroy edit update]
  resources :bookings, only: [] do
    # missing routes to display bookings on the venues
    # should we add a route to display availability for booking?
    resources :reviews, only: %i[create new]
  end
  resources :reviews, only: %i[show index] do
    collection do
      get :test_speed
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
