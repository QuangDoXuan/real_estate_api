Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  resources :projects, only: [:index, :create, :show, :update, :destroy]
  resources :products, only: [:index, :create, :show, :update, :destroy]
  resources :project_categories, only: [:index, :create, :show, :update, :destroy]
  resources :categories, only: [:index, :create, :show, :update]
  resources :companies, only: [:index, :create, :show, :update]
  resources :posts, only: [:index, :show]

  namespace :admin do
    resources :products
    resources :categories
    resources :companies
    resources :projects
    resources :posts
  end

  get '/category/getbyparent/:id' => 'categories#get_by_parent', as: "category_by_parent"
  get '/maps' => 'products#map', as: "map_product"
  get '/project_compare' => 'projects#get_by_name', as: "search_by_name_project"
  get '/admin_search_project/' => 'admin/projects#get_by_name', as: "admin_pr"
  get '/admin_s_product/' => 'admin/products#get_by_name', as: "admin_pd"
  get '/admin_s_company/' => 'admin/companies#get_by_name', as: "admin_cp"
  get '/filter' => 'products#filter', as: "filter_product"
  get '/getbyproject/:id' => 'projects#get_all_product', as: "get_by_project"
  get '/getbycompany/:id' => 'companies#get_all_projects', as: "get_by_company"

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
