Rails.application.routes.draw do
  resources :sales, only: [:index] do
    collection do
      get ':year/:month' => 'sales#index'
      get ':year/:month/transition/(:place_id)' => 'sales#transition', as: :transition
      get ':year/:month/places/:place_id' => 'sales#place', as: :places
      get ':year/:month/places/:place_id/edit' => 'sales#edit', as: :edit_place
      put ':year/:month/places/:place_id' => 'sales#update', as: :place
    end
  end

  resources :input_sales, only: [:index] do
    collection do
      get ':year/:month/places/:place_id/edit' => 'sales#edit', as: :edit_place
      put ':year/:month/places/:place_id' => 'sales#update', as: :place
    end
  end

  resources :cameras, only: [:index, :show] do
    resources :images, only: [:index]
  end

  resources :sales_files, only: [:index, :create] do
    member do
      get :download
    end
  end

  resources :mail_infos, only: [:index]

  resources :mail_files, only: [] do
    member do
      get :download
    end
  end

  root to: redirect('cameras')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
