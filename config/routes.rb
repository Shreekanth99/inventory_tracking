Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  get 'dashboard/index'
  root 'dashboard#index'
  resources :inventory_items
  get 'inventory_items/:id/view', to: 'inventory_items#view', as: 'view_inventory_item'
  patch 'inventory_items/:id', to: 'inventory_items#update', as: 'update_inventory_item'
  
end
