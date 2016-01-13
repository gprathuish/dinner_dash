Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :users, only: [:index, :status_toggle, :destroy] do
    member do
      get 'status_toggle'
    end
  end
  resources :welcome
  resources :registrations, only: [:new, :create]
  resources :sessions, only: [:create]
  resources :cart
  resources :categories
  resources :items
  resources :orders

  # match 'index/:id' => 'welcome#index', as: :index, via: :get  
  get 'index/:id' => 'welcome#index', as: :index
  get 'add_to_cart/:item_id' => 'cart#add_to_cart', as: :add_to_cart  
  get 'sign_in' => 'sessions#new', as: :login
  get 'sign_out' => 'sessions#destroy', as: :logout
  get 'checkout/:mode' => 'cart#check_out', as: :check_out


  #api calls
  namespace :api, defaults: {format: 'json'} do 

    #user
    match '/user/registration' => "users#registration", via: :post
    match '/user/login' => "users#login", via: :post
    match '/user/logout' => "users#logout", via: :get

    #welcome
    match '/all_items' => "welcome#index",  via: :get
    match '/item' => "welcome#show", via: :get
    match '/item_pic' => "welcome#picture", via: :get
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
