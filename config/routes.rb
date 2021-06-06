Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'auth#login'
      resources :pokemon
    end
  end
end