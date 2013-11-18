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

  get "group/show" 
  get "group/show_own"
  get "group/show_joined"
  get "group/show_profile"
  get "group/get_members"
  get "group/add_member"
  get "group/delete_member"
  get 'group/search_group'
  get 'group/create_group'
  get 'group/quit_group'
  get 'group/search_user'

  post "group/show"
  post "group/show_own"
  post "group/show_joined"
  post "group/show_profile"
  post "group/get_members"
  post "group/add_member"
  post "group/delete_member"
  post 'group/create_group'
  post 'group/quit_group'
  post 'group/search_user'

  get 'group/show/:page_id', to: 'group#show'
  get 'group/show_joined/:page_id', to: 'group#show_joined'
  get 'group/show_profile/:group_id', to: 'group#show_profile'
  get 'group/show_profile/:group_id/:page_id', to: 'group#show_profile'
  get 'group/add_member/:add_to_group_id', to: 'group#add_member'
  get 'group/add_other_member/:add_to_group_id/:add_user_id', to: 'group#add_other_member'
  get 'group/delete_member/:delete_from_group_id/:delete_user_id', to: 'group#delete_member'
  get 'group/quit_group/:quit_group_id', to: 'group#quit_group'
  get 'group/search_group/:search_gname/:page_id', to: 'group#search_group'
  get 'group/:group_id/search_user', to: 'group#search_user'
  get 'group/:group_id/search_user/:search_uname/:page_id', to: 'group#search_user'

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
