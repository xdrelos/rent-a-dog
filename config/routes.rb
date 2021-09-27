Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :dogs do
    resources :rentings, only: [:create, :update]
  end
  resources :rentings, only: [:edit, :destroy]
  get 'rentings/my-rentings', to: 'rentings#my_rentings'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
