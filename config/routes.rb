Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :collages, only: [:new, :create, :show] do
    resources :collage_items, only: [:new, :create]
  end
end
