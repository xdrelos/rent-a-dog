Rails.application.routes.draw do
  # mount ForestLiana::Engine => '/forest'
  devise_for :users
  resources :users, only: :show
  root to: 'pages#home'
  get 'dogs/my-dogs', to: 'dogs#my_dogs'
  resources :dogs do
    resources :rentings, only: [:create, :update]
    resources :reviews, only: :create
  end
  # route for fix the refresh after render a post with errors
  resources :rentings, only: [:edit, :destroy]
  get 'rentings/my-rentings', to: 'rentings#my_rentings'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "about", to: "pages#about"
end
