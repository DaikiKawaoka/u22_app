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
    @thing = Thing.find(params[:thing_id])
    unless @thing.iine?(current_user)
      @thing.iine(current_user)
      @thing.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @thing = Like.find(params[:id]).thing
    if @thing.iine?(current_user)
      @thing.uniine(current_user)
      @thing.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  # def create #いいね
  #   if Like.where(thing_id: params[:thing_id],user_id: @current_user.id).count == 0
  #     like=Like.create(thing_id: params[:thing_id],user_id: @current_user.id)
  #     #通知処理
  #     @thing = Thing.find(params[:thing_id])
  #     #通知の作成
  #     @thing.create_notification_by(current_user)
  #   end
  #   redirect_to("/things/#{params[:thing_id]}")
  # end

  # def destroy #いいねを外す
  #   if like=Like.find_by(thing_id: params[:thing_id],user_id: @current_user.id)
  #     like.destroy
  #   end
  #   redirect_to("/things/#{params[:thing_id]}")
  # end

  # def self_not_like
  #   thing=Thing.find_by(id: params[:thing_id])
  #   user=User.find_by(id: thing.user_id)
  #   if user.id==@current_user.id
  #     redirect_to("/things/#{params[:thing_id]}")
  #   end
  # end
end
