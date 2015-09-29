Rails.application.routes.draw do
 namespace :api, {default: :json} do
    namespace :v1 do
      resources :bucketlists
      resources :items
      resources :users
      get "auth/logout" => 'auth#logout'
      post "auth/login" => 'auth#login'
    end
  end
end