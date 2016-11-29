Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'
  get '/admin', to: 'static_pages#admin'

  resources :products
  get '/main', to: 'products#index_main'
  get '/delivery', to: 'products#index_delivery'
  get '/foodtrack', to: 'products#index_foodtrack'
  get '/products_index_adm', to: 'products#index_adm'

  resources :poster_clients, only: [:new, :create, :edit, :update]
  get '/poster_info', to: 'poster_clients#poster_info'
  get '/bonus_info', to: 'poster_clients#bonus_info'

  resources :poster_admin, only: [:index]
  post '/update_clients_bonus', to: 'poster_admin#update_clients_bonus'

end
