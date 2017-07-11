Rails.application.routes.draw do
  resources :sales, only: [:index]
  resources :cameras, only: [:index]

  resources :excels, only: [:index] do
    collection do
      get :import
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
