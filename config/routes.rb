Rails.application.routes.draw do
 #j'ai ajouté ces ressoures --> pas d'erreurs
  resources :users
  resources :categories
  #resources :forums
  resources :moderation
  resources :posts
  resources :topics

  # This line mounts Forem's routes at /forums by default.
  # This means, any requests to the /forums URL of your application will go to Forem::ForumsController#index.
  # If you would like to change where this extension is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Forem relies on it being the default of "forem"
  mount Forem::Engine, :at => '/forums'
  
  get '/', to: 'static#dashboard'

  get '/welcome', to: 'static#welcome'
  get '/contact', to: 'static#contact'
  post '/contact', to: 'static#send_contact'
  get '/about', to: 'static#about'
  get '/legal', to: 'static#legal'

  root 'static#dashboard'

  resource :sessions, only: [:create, :destroy]
  resources :users, only: [:edit, :update, :show]
  resource :reset_password

  resources :lessons do
    resources :chapters do
      resources :submissions do
        resource :validation
      end
    end
    resources :qcms do
      resources :questions do
        resources :answers
        get 'result'
      end
    end
    resources :exercices
  end

  resources :exercices do
    resources :essais
  end

  resources :messages do
    resources :comments
  end

  resources :tags

  resources :definitions

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
