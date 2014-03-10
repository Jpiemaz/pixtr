Pixtr::Application.routes.draw do
  root to: "galleries#index"
  get "/galleries/new" => "galleries#new"
  get "/galleries/:id" => "galleries#show", as: :gallery
  post "/galleries" => "galleries#create"
  get "/galleries/:id/edit" => "galleries#edit"
  patch "/galleries/:id" => "galleries#update"
  delete "/galleries/:id" => "galleries#destroy"
end
