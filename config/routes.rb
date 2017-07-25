Rails.application.routes.draw do
  resources :sales, only: [:index] do
    collection do
      get ':year/:month' => 'sales#index'
    end
  end
  resources :cameras, only: [:index]

  resources :sales_files, only: [:index, :create]

  root to: redirect('cameras')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
