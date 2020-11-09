Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"
    devise_for :users, skip: :omniauth_callbacks, controllers: {
        confirmations: "users/confirmations",
        registrations: "users/registrations"
      }
    get "/home", to: "static_pages#home"
    resources :users
    resources :chart
    resources :account_activations, only: [:edit]
    resources :plans, only: [:index, :new , :create] do
      collection do
        get "/reload_categories/", to: "plans#reload_categories"
      end
    end
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :categories, only: [:index, :create, :destroy]
    resources :shares, only: [:index, :new, :create] do
      collection do
        get "/get_month_from_user_shared/:from_user_id", to: "shares#get_month_from_user_shared"
      end
    end
    namespace :admin do
      root "static_pages#admin"
      resources :users, only: [:index, :show, :destroy]
    end

  end
  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
end
