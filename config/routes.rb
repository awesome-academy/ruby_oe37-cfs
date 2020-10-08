Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/home", to: "static_pages#home"
    get "/login", to: "sessions#new"
    post "/login",  to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
    resources:categories
end
