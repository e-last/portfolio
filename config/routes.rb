Rails.application.routes.draw do

  namespace :public do
    get 'search/search'
  end
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

    get 'users/quit' => 'users#quit'
    patch 'users/goodbye' => 'users#goodbye'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end


    resources :categories, only: [:index, :create, :edit, :update, :destroy] do
      member do
        get 'time' => 'categories#time'
      end
      resources :records, only: [:create]
    end

    post 'record/add' => 'records#add'
    resources :records, only: [:new, :index, :show, :edit, :update, :destroy] do
      member do
        patch 'finish' => 'records#finish'
      end
      resources :post_comments, only: [:create, :destroy]
    end

    get '/search' => 'search#search'
    
    get   'inquiry'         => 'inquiry#index'     # 入力画面
    post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
    post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面

    end

  end
