Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :collages, only: [:new, :create, :show] do
    resources :collage_items, only: [:new, :create, :show]
  end

  resources :quizzes, only: [:new, :create, :show] do
    resources :questions, only: [:create]
    end
    resources :questions, only: :show do
      resources :answers, only: [:create]
    end

  # get 'mixtapes/:id', to: "mixtapes#show"
  # get 'mixtapes/new', to: "mixtapes#new"
  # post 'mixtapes/new', to: 'mixtapes#create'

  resources :mixtapes, only: [:show, :new, :create]

end
