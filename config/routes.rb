Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'
  get '/admin', to: 'static_pages#admin'
  get '/test_payment', to: 'static_pages#test_payment'
  get '/news', to: 'static_pages#news'
  get '/users_index_adm', to: 'static_pages#users_index_adm'
  get 'user_adm/:id', to: 'static_pages#user_adm'

  resources :products
  get '/main', to: 'products#index_main'
  get '/foodtrack', to: 'products#index_foodtrack'
  get '/delivery', to: 'products#index_delivery'
  get '/delivery_products', to: 'products#index_delivery_products'
  get '/products_index_adm', to: 'products#index_adm'

  resources :poster_clients, only: [:new, :create, :edit, :update]
  get '/poster_info', to: 'poster_clients#poster_info'
  get '/bonus_info', to: 'poster_clients#bonus_info'
  get '/coupon', to: 'poster_clients#coupon'

  resources :poster_admin, only: [:index]
  post '/update_clients_bonus', to: 'poster_admin#update_clients_bonus'
  post '/update_poster_products', to: 'poster_admin#update_poster_products'

  # Yandex.Kassa
  post '/order_check', to: 'yandex_kassa#order_check'
  post '/order_payment_aviso', to: 'yandex_kassa#order_payment_aviso'
  get '/order_fail', to: 'yandex_kassa#order_fail'
  get '/order_success', to: 'yandex_kassa#order_success'

  # Shopping Cart
  resources :order_items, only: [:create, :update, :destroy]
  get '/cart', to: 'orders#cart'
  get '/order_placed', to: 'orders#order_placed'
  # get '/card_pay', to: 'orders#card_pay'
  resources :orders, only: [:update, :index, :show ]
  get "card_pay/:id", :controller => "orders", :action => "card_pay"
  get '/orders_index_adm', to: 'orders#index_adm'

end
