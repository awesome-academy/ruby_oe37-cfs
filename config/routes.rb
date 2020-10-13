Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/home", to: "static_pages#home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    get "/chart", to: "chart#show"
    post "/login", to: "sessions#create"
    get "/delete", to: "users#user_delete"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :account_activations, only: [:edit]
    resources :plan, only: [:new , :create]
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :categories, only: [:index, :create, :destroy]
  end
end
