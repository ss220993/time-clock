Rails.application.routes.draw do
  root to: 'time_sheet_entries#index'

  get '/signup', to: 'users#new'
  resources :users
  get    '/login',   to: 'users#login'
  post   '/login',   to: 'users#enter_log_in'
  delete '/logout',  to: 'users#logout'

  resources :time_sheet_entries, except: [:destroy] do
    collection do
      get 'add_or_view_entries', to: 'add_or_view_entries'
      get 'view_user_time_sheet', to: 'view_user_time_sheet'
      post 'create_time_sheet_user', to: 'create_time_sheet_user'
    end
    get 'clock_in_clock_out', to: 'clock_in_clock_out'

    member do
      post :clock_in, to: 'time_entries#clock_in'
      post :clock_out, to: 'time_entries#clock_out'
    end
  end
end
