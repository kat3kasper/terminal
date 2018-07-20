Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations], path: 'admins'
  devise_for :developers, path: 'developers', controllers: { registrations: :registrations }
  devise_for :recruiters, path: 'recruiters'

  root 'pages#home'
  get "/pages/:page", to: "pages#show", as: :pages
  get "jobsamples", to: "pages#jobsamples", as: :jobsamples

  resources :companies, only: [:new, :create, :edit, :update] do
    collection do
      get 'dashboard'
    end
  end

  resources :subscribers
  post '/stripe/webhooks', to: "stripe#webhooks"

  resources :developers do
    collection do
      get 'add_skills'
      get 'edit_profile'
      get 'dashboard'
    end
  end

  resources :jobs do
    resources :applications, only: [:new, :create, :show] do
      member do
        post 'contact'
        post 'reject'
      end
    end
    member do
      get 'skills'
      get 'benefits'
    end
  end


  authenticate :admin do
    namespace :admin do
      root 'dashboard#index'
      resources :dashboard, only: :index
      resources :competences
      resources :benefits
      resources :cultures
      resources :companies
      resources :recruiters
      resources :jobs
      resources :developers
      resources :applications, only: [:index, :show]
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :developers, only: [:create] do
      resources :skills, only: [:index, :create]
    end
    resources :jobs, only: [:create] do
      resources :skills, only: [:index, :create]
    end
  end
  delete "/api/developers/:developer_id/skills/:name", to: "api/skills#destroy"
  delete "/api/jobs/:job_id/skills/:name", to: "api/skills#destroy"

end
