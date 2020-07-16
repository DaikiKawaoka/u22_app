Rails.application.routes.draw do
  get 'keeps/create'
  get 'keeps/destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  #管理ページ
  root 'static_pages#index'
  get  '/signup',  to: 'users#new'
  #管理ページ絞り込み
  get  "/static_pages/:id/index"  => "static_pages#index_narrow"
  #世界ページ
  get "static_pages/home"=> "static_pages#home"
  #世界ページ絞り込み
  get  "/static_pages/:id"  => "static_pages#home_narrow"
#通知ページ
  delete "/notifications/destroy_all" , to: "notifications#destroy_all"
  resources :notifications, only: :index
  resources :users
  get    '/login',   to: 'sessions#new'  #新しいセッションのページ (ログイン)
  post   '/login',   to: 'sessions#create'  #新しいセッションの作成 (ログイン)
  delete '/logout',  to: 'sessions#destroy'  #セッションの削除 (ログアウト)
 #guest_userでログイン
  get  '/guestlogin', to: 'sessions#guestlogin'
  resources :things do
    resources :comments, only: [:create, :destroy]  #物へのコメント
  end
  get   '/kensaku', to:'users#kensaku'
  # post '/likes/:thing_id/create', to:'likes#create'#いいね
  # delete '/likes/:thing_id/destroy', to:'likes#destroy' #いいねを外す
  # get '/likes/:id', to:'likes#show' #いいね一覧
  resources :likes, only: [:create, :destroy]

  # post '/keeps/:thing_id/create', to:'keeps#create'#keepする
  # delete '/keeps/:thing_id/destroy', to:'keeps#destroy' #keepを外す
  resources :keeps, only: [:create, :destroy]

#/users/1/following的な
  resources :users do
    member do
      get :following, :followers,:keep,:like
    end
  end
  resources :account_activations, only: [:edit]
#パスワードをリセットするパス
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :password_edit,     only: [:edit,:update]
  resources :relationships,       only: [:create, :destroy]
  # GET	/users	index	users_path すべてのユーザーを一覧するページ
  # GET	/users/1	show	user_path(user) 特定のユーザーを表示するページ
  # GET	/users/new	new	new_user_path ユーザーを新規作成するページ (ユーザー登録)
  # POST	/users	create	users_path ユーザーを作成するアクション
  # GET	/users/1/edit	edit	edit_user_path(user) id=1のユーザーを編集するページ
  # PATCH	/users/1	update	user_path(user) ユーザーを更新するアクション
  # DELETE	/users/1	destroy	user_path(user) ユーザーを削除するアクション
end
