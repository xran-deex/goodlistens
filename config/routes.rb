Goodlistens::Application.routes.draw do
  get "album/details"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match 'auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  get "login/index"
  post 'search', to: 'application#search', as: :search
  get 'details', to: 'application#details', as: :details
  post 'rate', to: 'application#rate', as: :rate_album

  get 'home', to: 'users#index', as: :user
  get 'newuser', to: 'users#newuser', as: :newuser
  get 'browse', to: 'users#newuser'
  post 'newuser/rate', to: 'users#rate', as: :rate
  get 'newuser/next_albums', to: 'users#next_albums', as: :get_more
  get 'newuser/prev_albums', to: 'users#prev_albums', as: :get_less

  root :to => 'application#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
