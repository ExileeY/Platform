Rails.application.routes.draw do
  get 'profile/:id', to: 'persons#profile', as: 'profile'
  get '/moon', to: 'application#moon', as: 'moon'
  get '/sun', to: 'application#sun', as: 'sun'
  get '/rating_sort', to: 'projects#rating_sort', as: 'rating_sort'
  get '/created_at_sort', to: 'projects#created_at_sort', as: 'created_at_sort'
  get '/updated_at_sort', to: 'projects#updated_at_sort', as: 'updated_at_sort'


  devise_for :users, controllers: { omniauth_callbacks:"users/omniauth_callbacks", registrations: "users/registrations" }

  resources :projects do
  	resources :comments
    resources :reviews
    resources :events
  end

  resources :comments do
  	resources :likes
  end
  
  resources :project_images


  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
