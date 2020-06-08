class StaticPagesController < ApplicationController
  def home
    if current_user
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    @things=Thing.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: current_user.id)
    end
  end
end
