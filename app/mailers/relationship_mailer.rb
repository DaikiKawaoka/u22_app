class RelationshipMailer < ApplicationMailer
#フォロー時に通知
  def follow_notification(user, follower)
    @user = user
    @follower = follower
    mail to: user.email, subject: "#{@follower.name} があなたをフォローしました。"
  end
#フォロー解除時に通知
  def unfollow_notification(user, follower)
    @user = user
    @follower = follower
    mail to: user.email, subject: "#{@follower.name} があなたのことをフォロー解除しました。"
  end
end
