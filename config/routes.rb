Rails.application.routes.draw do
  root "posts#index"

  # * Posts
  get "/posts", to: "posts#index", as: :posts
  get "/posts/new", to: "posts#new", as: :new_post
  get "/posts/:id", to: "posts#show", as: :post
  post "/posts", to: "posts#create", as: :create_post
end
