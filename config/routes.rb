Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"
 
  root to: "home#index"
  
  resources :galleries do
    resources :images, only: [:new, :create]
  end
  
  resources :images, except: [:index, :new, :create] do
    resources :comments, only: [:create]
  end
end
