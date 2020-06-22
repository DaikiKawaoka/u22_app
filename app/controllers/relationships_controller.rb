class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    #通知の作成
    @user.create_notification_follow!(current_user)
    respond_to do |format|     # RelationshipsコントローラでAjaxリクエストに対応する
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|     # RelationshipsコントローラでAjaxリクエストに対応する
      format.html { redirect_to @user }
      format.js
    end
  end
end
