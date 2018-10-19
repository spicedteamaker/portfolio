Rails.application.routes.draw do

  get 'header_images/new'
  post 'header_images/create'
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    mailer: 'users/mailer',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    shared: 'users/shared',
    unlocks: 'users/unlocks'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  resources :posts
  get 'catalog', to: 'posts#catalog'
  resources :portfolio_posts

end
