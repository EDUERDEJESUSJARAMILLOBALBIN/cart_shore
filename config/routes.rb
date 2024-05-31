Rails.application.routes.draw do
  get 'cart/show', to: 'cart#show'
  post 'cart/add'
  delete 'cart/remove', to: 'cart#remove'
  resources :products
  root 'products#index'
  resources :orderables, only: [:index] do
    collection do
      post 'create_order'
      delete 'delete_order/:order_code', to: 'orderables#delete_order', as: 'delete_order'
    end
  end
end
