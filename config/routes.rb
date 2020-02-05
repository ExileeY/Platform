Rails.application.routes.draw do
  get 'profile/:user_id' => 'persons#profile', as: :profile
  devise_for :users
  resources :projects, :shallow => true do
  	resources :comments
  end

  root 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
