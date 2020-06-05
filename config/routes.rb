Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/signup',  to: 'users#new'
  resources :users
  get    '/login',   to: 'sessions#new'  #新しいセッションのページ (ログイン)
  post   '/login',   to: 'sessions#create'  #新しいセッションの作成 (ログイン)
  delete '/logout',  to: 'sessions#destroy'  #セッションの削除 (ログアウト)
  resources :things
  get   '/kensaku', to:'users#kensaku'


#/users/1/following的な
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships,       only: [:create, :destroy]

  # GET	/users	index	users_path すべてのユーザーを一覧するページ
  # GET	/users/1	show	user_path(user) 特定のユーザーを表示するページ
  # GET	/users/new	new	new_user_path ユーザーを新規作成するページ (ユーザー登録)
  # POST	/users	create	users_path ユーザーを作成するアクション
  # GET	/users/1/edit	edit	edit_user_path(user) id=1のユーザーを編集するページ
  # PATCH	/users/1	update	user_path(user) ユーザーを更新するアクション
  # DELETE	/users/1	destroy	user_path(user) ユーザーを削除するアクション
end
