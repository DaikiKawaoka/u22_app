class SessionsController < ApplicationController

  def new
  end

  def create
    user = login_text_check(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user
      redirect_to user
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'ログイン失敗' # 本当は正しくない
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end


  private

  #  user_name か email かをチェック
    def login_text_check(text)
      user = User.find_by(email: text.downcase)
      unless user then
        user = User.find_by(user_name: text)
        return user
      end
      return user
    end
end
