Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root to: "home#index"

  resources :tags, only: [:show]

  resource :account, only: [:show]
  resources :charges, only: [:create]

  resource :dashboard, only: [:show]
  resource :search, only: [:show]
  resources :galleries do
    resources :images, only: [:new, :create]
    member do
      post "like" => "gallery_likes#create"
      delete "unlike" => "gallery_likes#destroy"
    end
  end

  resources :groups, only: [:index, :new, :create, :show] do
    member do
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
      post "like" => "group_likes#create"
      delete "unlike" => "group_likes#destroy"
    end
  end

  resources :images, except: [:index, :new, :create] do
    member do
      post "like" => "image_likes#create"
      delete "unlike" => "image_likes#destroy"
    end
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy]

  resources :users, only: [:show] do
    member do
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end
end
