Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks:"users/omniauth_callbacks", registrations: "users/registrations" }
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'profile/:id', to: 'persons#profile', as: 'profile'
    get '/moon', to: 'application#moon', as: 'moon'
    get '/sun', to: 'application#sun', as: 'sun'
    get '/rating_sort', to: 'projects#rating_sort', as: 'rating_sort'
    get '/created_at_sort', to: 'projects#created_at_sort', as: 'created_at_sort'
    get '/updated_at_sort', to: 'projects#updated_at_sort', as: 'updated_at_sort'
    get '/profile/:id/give_permission', to: 'persons#give_permission', as: 'give_permission'
    get '/profile/:id/take_away_permission', to: 'persons#take_away_permission', as: 'take_away_permission'
    get '/profile/:id/ban', to: 'persons#ban', as: 'ban'
    get '/profile/:id/unban', to: 'persons#unban', as: 'unban'
    get '/profile/:id/ban_page', to: 'persons#ban_page', as: 'ban_page'
    delete '/profile/:id', to: 'persons#delete_user'
    get '/profile/:id/projects/new', to: 'persons#new_user_project', as: 'user_project_new'
    post '/profile/:id/projects', to: 'persons#create_user_project'
    get '/bonus/:bonus_id/user_bonus/create', to: 'user_bonuses#create', as: 'user_bonus_create'
    get 'projects/:project_id/transaction/new', to: 'transactions#new', as: 'new_project_transaction'
    post '/projects/:project_id/transactions', to: 'transactions#create'
    get '/add_balance/new', to: 'add_balances#new', as: 'new_add_balance'
    post '/add_balance/create', to: 'add_balances#create'
    get '/tagged', to: "projects#tagged", as: 'tagged'
    devise_for :users, skip: :omniauth_callbacks, controllers: { omniauth_callbacks:"users/omniauth_callbacks", registrations: "users/registrations" }




    resources :projects do
    	resources :comments
      resources :reviews
      resources :events
    end

    resources :comments do
    	resources :likes
    end
    
    resources :project_images
    resources :bonuses


    root 'projects#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
