Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"
  
  resources :users, only: [:new, :create]
  
  resource :session, only: [:new, :create, :destroy]
 
  root to: "galleries#index"
  resources :galleries do
    resources :images, shallow: true
  end
end
