Rails.application.routes.draw do
  # * Clearance
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: :sign_in
  delete "/sign_out" => "clearance/sessions#destroy", as: :sign_out
  get "/sign_up" => "clearance/users#new", as: :sign_up

  constraints Clearance::Constraints::SignedIn.new  do
    root to: "posts#index", as: :authenticated_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "clearance/sessions#new", as: :unauthenticated_root
  end

  # * Blog
  resources :posts do
    resource :cover_image, only: [:destroy], module: :posts
  end

  get "*segment" => redirect("/"), segment: /(?!rails).*/
end
