class StaticPagesController < ApplicationController
  #地球ページ
  def home
    if current_user
    # following_ids = "SELECT followed_id FROM relationships
    #                  WHERE follower_id = :user_id"
    # @things=Thing.where("user_id IN (#{following_ids})
    #                  OR user_id = :user_id", user_id: current_user.id)
    @things=Thing.all
    end
  end
#地球絞り込みページ
  def home_narrow
    if current_user
      thing_type = params[:id]
      @things=Thing.where(thing_type: thing_type)
    end
  end

  #管理ページ
  def index
    if current_user
      @things=current_user.things
    end
  end

#管理絞り込みページ
  def index_narrow
    if current_user
      thing_type = params[:id]
      @things=Thing.where(thing_type: thing_type)
    end
  end
end
