Rails.application.routes.draw do
  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  resources :features do
    resources :comments, only: [:create, :destroy]
    post 'vote', to: 'features#vote'
  end

  root 'features#index'
end
