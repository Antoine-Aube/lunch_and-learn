Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/api/v1/recipes", to: "api/v1/recipes#index"
  get "/api/v1/tourist_sites", to: "api/v1/tourist_sites#index"
end
