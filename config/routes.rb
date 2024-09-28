Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  root to: 'pages#index'

  resource :about, only: %i[show edit update]
  resource :contact, only: %i[new create]
  resources :packages
  
  resources :photo_albums do
    resources :photos
  end

  resources :reviews, only: %i[index new create destroy]
  # resources :purchases, only: [:new, :create] do
  #   get 'receipt', to: 'purchases#receipt', as: :receipt
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
