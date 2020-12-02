Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :quizzes, only: [:new, :create, :show] do
    resources :questions, only: [:create]
    end
    resources :questions, only: :show do
      resources :answers, only: [:create]
    end
end
