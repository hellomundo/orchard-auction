Rails.application.routes.draw do
  resources :lots do
    resources :items, only: [:update, :destroy]

    member do
      get :toggle
    end

    collection do
      get 'generate'
      get 'destroy_all'
    end

  end

  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'application#index'

  resources :donors do
    resources :contacts
    resources :items

    collection do
      get 'destroy_all'
      post 'import'
    end
  end

  resources :buyers do
    collection do
#      get 'destroy_all'
      post 'import'
    end
  end

  resources :wins

  resources :pledges

  resources :items do #, only: [:index, :destroy, :import]
    collection do
      post 'import'
    end

  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
