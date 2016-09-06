Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create, :index, :show]
    resource :profile, controller: 'users', only: [:show, :update]

    resource :session, only: [:create, :destroy]

    resources :chats, only: [:create, :index, :show] do
      resources :messages, only: [:create, :index, :show]
      resource :mark_as_readed, to: 'chats#mark_as_readed', only: :show
    end
  end
end
