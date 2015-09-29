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
end