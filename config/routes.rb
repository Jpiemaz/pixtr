Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"
 
  root to: "galleries#index"
  resources :galleries do
    resources :images
  end
end
