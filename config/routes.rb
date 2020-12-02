Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # get 'mixtapes/:id', to: "mixtapes#show"
  # get 'mixtapes/new', to: "mixtapes#new"
  # post 'mixtapes/new', to: 'mixtapes#create'

  resources :mixtapes, only: [:show, :new, :create]

end
