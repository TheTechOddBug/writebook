Rails.application.routes.draw do
  root "books#index"

  resource :first_run, only: %i[ show create ]
  resource :session, only: %i[ new create destroy ]

  get "join/:join_code", to: "users#new", as: :join
  post "join/:join_code", to: "users#create"

  resources :users, only: :show do
    scope module: "users" do
      resource :avatar, only: %i[ show destroy ]
    end
  end

  direct :fresh_user_avatar do |user, options|
    route_for :user_avatar, user.avatar_token, v: user.updated_at.to_fs(:number)
  end

  resources :books do
    resources :leaves
    resources :sections
    resources :pictures

    resources :pages do
      scope module: "pages" do
        resources :edits, only: :show
      end
    end
  end

  direct :leafable do |leaf, options|
    route_for "book_#{leaf.leafable_name}", leaf.book, leaf.leafable, options
  end

  direct :edit_leafable do |leaf, options|
    route_for "edit_book_#{leaf.leafable_name}", leaf.book, leaf.leafable, options
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
