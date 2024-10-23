Rails.application.routes.draw do
  resources :products
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :orders, only: %i[index create]

  resources :cart_items, only: %i[index create destroy] do
    collection do
      post 'update_quantity', to: 'cart_items#update_quantity', as: 'update_quantity'
    end
  end

  post 'order_product', to: 'orders#order_product', as: 'order_product'
end
