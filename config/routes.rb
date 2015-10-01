Rails.application.routes.draw do
 namespace :api, {default: :json} do
    namespace :v1 do
      resources :bucketlists do
        resources :items
      end
      resources :users
      get "auth/logout" => 'auth#logout'
      post "auth/login" => 'auth#login'
    end
  end

  match "*path", to: "api/v1/errors#not_found", via: :all, as: "not_found"
end