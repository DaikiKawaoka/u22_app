class LikesController < ApplicationController
  before_action :logged_in_user

  def show
    thing_array = []
    likes = Like.where(user_id: params[:id])
     likes.each{|like|
       thing_array << like.thing_id
   }
    @things = Thing.where(id: thing_array).order(created_at: :asc)
  end

  def create
    unless(guest_user?)
      @thing = Thing.find(params[:thing_id])
      unless @thing.iine?(current_user)
        @thing.iine(current_user)
        @thing.reload
        #通知の作成
        @thing.create_notification_by(current_user)
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
