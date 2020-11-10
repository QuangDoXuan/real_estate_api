Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  resources :projects, only: [:index]
  resources :products, only: [:index, :show]
  resources :product_categories, only: [:index, :show]

  get '/maps' => 'products#map', as: "map_product"

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
