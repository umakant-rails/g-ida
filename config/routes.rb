Gida::Application.routes.draw do

  root 'home#index'

  
  #namespace :admin do
  scope '/admin' do
    resources :responses
    resources :answers
    resources :polls
  end
  
  resources :invitations do
    member do
      get :invitations_polls
    end

    collection do
      get :fetch_polls_to_invited_people
      get :invite_to_invited_peoples
    end
  end

  resources :clients do
    delete :mark_as_deleted, as: :mark_as_deleted
  end

  devise_for :users, :controllers => { :registrations => "users/registrations"}
  devise_scope :user do
    get "users/:id/profile", :to => "devise/registrations#profile", :as => "profile" 
  end
  match 'poll/:id/vote' => 'polls#vote', via: :get, as: :vote_poll
  match 'poll/:id/response_to_poll' => 'polls#response_to_poll', via: :post, as: :response_to_poll
  match 'poll/:pollid/:userid(/:answerid)' => 'poll#take', via: [:get, :post]
  match 'poll/submit' => 'poll#submit', via: :post
  match 'poll/thankyou' => 'home#pollsubmitted', via: :get 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
