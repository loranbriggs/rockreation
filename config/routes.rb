Rockreation::Application.routes.draw do

  get "seats" => "seats#list", :as => "seats"
  get "seats/update"
  get "seats/show"
  resources :seats


  get "shifts/show"
  get "shifts" => "shifts#list",:as => "shifts"
  get "shifts/update"
  resources :shifts

  get "xref_user_reservations/show"
  get "reservation_shifts" => "xref_user_reservations#list", :as => "reservation_shifts"
  resources :xref_user_reservations

  get "reservations/show"
  get "reservations/edit"
  get "reservations_list" => "reservations#list", :as => "reservations_list"
  get "reservations" => "reservations#calendar", :as => "reservations"
  get "reserve" => "reservations#new", :as => "reserve"
  resources :reservations


  get "events/show"
  get "events/edit"
  get "parties" => "events#calendar_parties", :as => "parties"
  get "parties_list" => "events#list_parties", :as => "parties_list"
  get "events" => "events#calendar_events", :as => "events"
  get "events_list" => "events#list_events", :as => "events_list"
  get "new_event" => "events#new", :as => "new_event"
  resources :events


  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "users" => "users#index", :as => "users"
  resources :sessions


  get "sign_up" => "users#new", :as => "sign_up"
  resources :users

  get "home" => "static_pages#home", :as => "home"
  root :to => "static_pages#home"
  resources :static_pages

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
