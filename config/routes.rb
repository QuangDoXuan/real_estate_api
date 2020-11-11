Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  resources :projects, only: [:index, :create, :show, :update, :destroy]
  resources :products, only: [:index, :create, :show, :update, :destroy]
  resources :project_categories, only: [:index, :create, :show, :update, :destroy]
  resources :categories, only: [:index, :create, :show, :update]
  resources :companies, only: [:index, :create, :show, :update]

  get '/maps' => 'products#map', as: "map_product"

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
