class PasswordEditController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user && @user.authenticate(params[:user][:password_now])  #現在のパスワードが正しいかどうか
      if params[:user][:password].empty?                  #新しいパスワードが空文字列になっていないか
        @user.errors.add(:password, 'パスワードが空です')
        render 'edit'
      elsif @user.update(user_password_update)                     #新しいパスワードが正しければ、更新する
        log_in @user
        flash[:success] = "パスワードがリセットされました。"
        redirect_to @user
      else
        @user.errors.add(:password, 'パスワードが無効です')
        render 'edit'            # 無効なパスワードであれば失敗させる（失敗した理由も表示する）
      end
    else
      @user.errors.add(:password_now, '現在のパスワードが違います')
      render 'edit'  # 無効なパスワードであれば失敗させる（失敗した理由も表示する）
    end
  end

  private
  def user_password_update
    params.require(:user).permit(:password,:password_confirmation)
  end
end
