class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def Relationship.send_follow_email(user, follower)
    RelationshipMailer.follow_notification(user, follower).deliver_now
  end

  def Relationship.send_unfollow_email(user, follower)
    RelationshipMailer.unfollow_notification(user, follower).deliver_now
  end
end
