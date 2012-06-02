Baseapp::Application.routes.draw do

  # The front end site
  
  get 'pages/index', :via => [:get]
  
  match 'pricing', :to => 'pages#pricing', :via => [:get]
  
  match 'accounts/new/:plan_name', :to => 'accounts#new', :as => 'signup', :via => [:get]
  
  # Recurly callback
  match 'accounts/complete_signup/:id', :to => 'accounts#complete_signup', :as => 'complete_signup', :via => [:get]
  
  # Recurly subscriptions
  
  match '/subscriptions', :to => 'subscriptions#index', :via => [:get]
  match '/subscriptions/close_account', :to => 'subscriptions#close_account', :via => [:get]
  
  devise_for :users, 
             :path_names => { :sign_in => 'login', 
                              :sign_up => 'new', 
                              :sign_out => 'logout', 
                              :password => 'password', 
                              :confirmation => 'confirmation' }
  
  # When we log in a user through Devise, redirect them to the dashboard
  
  match 'user', :to => 'dashboards#index', :as => :user_root, :via => [:get]
  
  # Project dashboard
  
  match 'dashboard', :to => 'dashboards#index', :via => [:get]
  
  # Resource routes
  resources :accounts
  resources :subscriptions
  resources :projects
  resources :issues
  resources :uploads
  resources :clients
  resources :tasks
  resources :invoices
  resources :expenses
  
  match 'finances', :to => 'finances#index', :via => [:get]
  match 'uploads/:user_id/share/:id', :to => 'uploads#share', :via => [:get]
  match 'invoices/:user_id/view/:id', :to => 'invoices#view', :via => [:get]
  
  # API 
  
  namespace :api_v1 do
    scope ':key' do
      resources :projects
    end
  end
     
  # Default route
  
  root :to => 'pages#index', :via => [:get]

end
