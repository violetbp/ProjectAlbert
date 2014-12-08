Rails.application.routes.draw do

  #get 'users/new'

  resources :problemsets
  resources :problems
  resources :users
  resources :groups
  resources :jobs

  get '/jobs/grade/:id', to: 'jobs#grade', as: 'grade' 
  get '/jobs/set_submitted/:id', to: 'jobs#set_submitted', as: 'set_submitted' 
  get '/jobs/set_not_submitted/:id', to: 'jobs#set_not_submitted', as: 'set_not_submitted'

  get '/patients/:id', to: 'patients#show', as: 'patient'

  resources :process_file
  
  #match '/signup',  to: 'users#new',            via: 'get'
  #match '/signin',  to: 'sessions#new',         via: 'get'
  #match '/signout', to: 'sessions#destroy',     via: 'delete'
  
  #for upload file
  match "/upload/.format", to: "problems#upload", via: "post"
  match "/update_test_data/(.format)", to: "problems#update_test_data", via: "post"
  match "/makedir/.format", to: "problems#makedir", via: "get"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]

  root 'problemsets#index'
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
