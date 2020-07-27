module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_thing = link_to 'あなたの投稿', thing_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then #thing_path(thing),   user_path(thing.user)
        tag.a(notification.visiter.user_name, href:user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.user_name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('投稿', href:thing_path(notification.thing_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visiter_comment)&.content
          tag.a(@visiter.name, href:user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('投稿', href:thing_path(notification.thing_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  #未確認の通知(checked:falseの通知)を示すunchecked_notificationsメソッド
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
 end
end
