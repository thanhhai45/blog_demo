Rails.application.routes.draw do
  resources :categories
  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/posts'
    get 'admin/comments'
    get 'admin/users'
    get 'admin/show_post/:id', to: 'admin#show_post', as: 'admin_post'
  end
  get 'search', to: 'search#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :after_signup

  get 'u/:id', to: 'users#profile', as: 'user'

  # /posts/1/comments/1
  resources :posts do
    resources :comments
  end
  get 'about', to: 'pages#about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
end
