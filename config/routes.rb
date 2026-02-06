Rails.application.routes.draw do
  devise_for :users
  root to: "goods#index"
  resources :goods, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    resources :purchases, only: [:index, :create]
  end
end
