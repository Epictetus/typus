Rails.application.routes.draw do

  scope Typus.prefix, :module => :admin, :as => "admin" do

    match "/" => redirect("/#{Typus.prefix}/dashboard")
    match "help" => "base#help"

    resource :dashboard, :only => [:show], :controller => :dashboard

    if Typus.authentication == :session
      resource :session, :only => [:new, :create, :destroy], :controller => :session
      resources :account, :only => [:new, :create, :show, :forgot_password] do
        collection { get :forgot_password }
      end
    end

    controller "resources" do
      match "/:model_name/(:action(/:id(.:format)))"
    end

  end

end
