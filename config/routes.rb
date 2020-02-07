Rails.application.routes.draw do
  get 'profile/:id' => 'persons#profile', as: :profile
  devise_for :users
  resources :projects do
  	resources :comments
  end
  resources :project_images


  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
