FaceCalendar::Application.routes.draw do

  get "calendar/edit_propose"
  get "calendar/backup"
  get "calendar/create_event"
  get "calendar/edit"
  get "calendar/show_event"
  get "calendar/show_month"
  get "search/group"
  get "search/event"
  get "search/user"
  get "calendar/show"
  post "calendar/create_event"
  post "calendar/edit_propose"

  get 'login/start'
  get 'login/tryAgain'
  get 'login/logout'
  get 'login/login'
  get 'login/signup'

  get "profile/show"
  get "profile/ret_data"
  post "profile/update_info"
  post "profile/uploadPic"


#  controller :login do
#    get 'logout' => logout
#  end

  get "group/show_own"
  get "group/show_joined"
  get "group/show_members"
  get "group/show_frame"

  get "sqltest/test"
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
   root :to => 'login#start'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
