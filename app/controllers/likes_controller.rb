class LikesController < ApplicationController

  before_action :self_not_like

  def create #いいね
    if Like.where(thing_id: params[:thing_id],user_id: @current_user.id).count == 0
      like=Like.create(thing_id: params[:thing_id],user_id: @current_user.id)
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
