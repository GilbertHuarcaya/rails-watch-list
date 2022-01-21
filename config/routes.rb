Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "lists#index"
  resources :lists, except: :index do
    resources :bookmarks, only: [:new, :create]
    delete "bookmarks/:id", to: "bookmarks#destroy", as: "destroy_bookmark"
  end
end
