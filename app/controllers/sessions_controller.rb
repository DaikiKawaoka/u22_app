class SessionsController < ApplicationController

  def new
  end

  def create
    user = login_text_check(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
    else
      # エラーメッセージを作成する
      flash[:danger] = 'ログイン失敗' # 本当は正しくない
      render 'new'
    end
  end

  def destroy
  end


  private

  #  user_name か email かをチェック
    def login_text_check(text)
      unless user = User.find_by(email: text.downcase) then
        user = User.find_by(user_name: text)
      end
    end
end
