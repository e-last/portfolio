Rails.application.routes.draw do

  devise_for :admins, skip: :all

  devise_scope :admin do
    get 'admins/sign_in' => 'admin/sessions#new', as: :new_admin_session
    post 'admins/sign_in' => 'admin/sessions#create', as: :admin_session
    delete 'admins/sign_out' => 'admin/sessions#destroy', as: :destroy_admin_session
  end

  namespace :admin do
    resources :users,only: [:index, :edit, :update]
    resources :records,only: [:index, :edit, :update, :destroy]
  end

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }

  scope module: :public do

    root 'homes#top'

    get 'user/quit' => 'users#quit'
    patch 'user/goodbye' => 'users#goodbye'
    resource :user, only: [:show, :edit, :update]

    resources :categories, only: [:index, :create, :edit, :update, :destroy] do
      member do
        get 'time' => 'categories#time'
      end
      resources :records, only: [:create]
    end

    resources :records, only: [:index, :show, :edit, :update, :destroy] do
      member do
        patch 'finish' => 'records#finish'
      end

    end

    end

  end
