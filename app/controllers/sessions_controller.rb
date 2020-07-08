class SessionsController < ApplicationController

  def new
  end

  def create
    user = login_text_check(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "アカウントがまだアクティブ化されていません。 "
        message += "先ほど送られたメールを確認してください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # エラーメッセージを作成する
      flash[:danger] = 'ログイン失敗'
      redirect_to root_url
    end
  end

    def destroy
      log_out if logged_in?
      redirect_to "/login"
    end

    def guestlogin
      user = User.find(1)
      log_in(user)
      redirect_back_or user
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
