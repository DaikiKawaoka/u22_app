class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    unless(guest_user?)
      @thing = Thing.find(params[:thing_id])
      unless @thing.iine?(current_user)
        @thing.iine(current_user)
        @thing.reload
        #通知の作成
        #いいねした人とものを登録した人が違ったら通知を作成
        unless(current_user.id == @thing.user.id)
          @thing.create_notification_by(current_user)
        end
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to "/login"
    end
  end

  def destroy
    unless(guest_user?)
      @thing = Like.find(params[:id]).thing
      if @thing.iine?(current_user)
        @thing.uniine(current_user)
        @thing.reload
        respond_to do |format|
          format.html { redirect_to request.referrer || root_url }
          format.js
        end
      end
    else
      redirect_to "/login"
    end
  end
end
