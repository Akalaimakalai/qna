Rails.application.routes.draw do
  root to: 'questions#index'

  devise_for :users

  resources :questions do
    resources :answers, except: %i[ index new ], shallow: true do
      post 'best', on: :member
      resources :comments, shallow: true, only: %i[create destroy]
    end

    resources :comments, shallow: true, only: %i[create destroy]
  end

  resources :files, only: %i[ destroy ]
  resources :links, only: %i[ destroy ]
  resources :medals, only: %i[ index ]
  resources :votes, only: %i[ create ]

  mount ActionCable.server => '/cable'
end
