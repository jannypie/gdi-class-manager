root to: 'users#index'
resources :users
resources :sessions, only: [:new, :create, :destroy]
