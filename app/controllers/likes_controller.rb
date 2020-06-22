class LikesController < ApplicationController

  before_action :self_not_like, only:[:create,:destroy]

  def show
    thing_array = []
    likes = Like.where(user_id: params[:id])
     likes.each{|like|
       thing_array << like.thing_id
   }
    @things = Thing.where(id: thing_array)
  end

  def create #いいね
    if Like.where(thing_id: params[:thing_id],user_id: @current_user.id).count == 0
      like=Like.create(thing_id: params[:thing_id],user_id: @current_user.id)
      #通知処理
      @thing = Thing.find(params[:thing_id])
      #通知の作成
      @thing.create_notification_by(current_user)
    end
    redirect_to("/things/#{params[:thing_id]}")
  end

  def destroy #いいねを外す
    if like=Like.find_by(thing_id: params[:thing_id],user_id: @current_user.id)
      like.destroy
    end
    redirect_to("/things/#{params[:thing_id]}")
  end

  def self_not_like
    thing=Thing.find_by(id: params[:thing_id])
    user=User.find_by(id: thing.user_id)
    if user.id==@current_user.id
      redirect_to("/things/#{params[:thing_id]}")
    end
  end
end
