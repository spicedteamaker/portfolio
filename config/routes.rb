Rails.application.routes.draw do

  get 'header_images/new'
  post 'header_images/create'
  devise_for :users
  as :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    #get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  resources :posts
  get 'catalog', to: 'posts#catalog'
  resources :portfolio_posts

end
