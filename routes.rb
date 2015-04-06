root to: 'users#index'
resources :users
resources :session, only: [:new, :create, :destroy]
