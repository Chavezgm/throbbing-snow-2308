Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :airlines do
    resources :flights, only: [:index, :show, :new, :create]
  end
  
  resources :flights, only: [:index, :show, :new, :create] do
    resources :passengers, only: [:index, :show, :new, :create, :destroy],  controller: 'passenger_flights'
  end
  
  resources :passengers, only: [:index, :show, :new, :create]
end
