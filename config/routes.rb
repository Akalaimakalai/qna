Rails.application.routes.draw do
  use_doorkeeper

  concern :commentable do
    resources :comments, shallow: true, only: %i[create destroy]
  end

  root to: 'questions#index'

  devise_for :users, controllers: { omniauth_callbacks: 'oauth_callbacks' }

  resources :questions, concerns: %i[commentable] do
    resources :answers, except: %i[ index new ], shallow: true, concerns: %i[commentable] do
      post 'best', on: :member
    end
  end

  resources :files, only: %i[ destroy ]
  resources :links, only: %i[ destroy ]
  resources :medals, only: %i[ index ]
  resources :votes, only: %i[ create ]

  namespace :api do
    namespace :v1 do
      resources :profiles, only: [] do
        get :me, on: :collection
      end

      resources :questions, only: %i[ index ]
    end
  end

  mount ActionCable.server => '/cable'
end
