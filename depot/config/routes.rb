Rails.application.routes.draw do
  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # set the root page to be the /products page
  root 'products#index'
end
