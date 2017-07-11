Rails.application.routes.draw do
  resources :sales, only: [:index]
  resources :cameras, only: [:index]

  resources :sales_files, only: [:index, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
