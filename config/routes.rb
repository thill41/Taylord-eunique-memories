Rails.application.routes.draw do
  devise_for :users
  
  root to: 'pages#index'

  # GET    /about(.:format)
  # GET    /about/edit(.:format)
  # PATCH  /about(.:format)
  resource :abouts, only: %i[show edit update], path: 'about'
  resources :photo_albums do
    resources :photos, except: %i[index]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
