Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :curated_lists, only: [:new, :create, :show] do
    resources :curated_list_items, only: [:create]
  end
end
