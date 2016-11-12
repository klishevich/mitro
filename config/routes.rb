Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'
  get '/admin', to: 'static_pages#admin'

  resources :products
  get '/delivery', to: 'products#index_delivery'
  get '/sibirskaya', to: 'products#index_sibirskaya'
  get '/volochaevskaya', to: 'products#index_volochaevskaya'
  get '/foodtrack', to: 'products#index_foodtrack'
  get '/products_index_adm', to: 'products#index_adm'

  resources :poster_clients, only: [:new, :create, :edit, :update]
  get '/poster_info', to: 'poster_clients#poster_info'
end
