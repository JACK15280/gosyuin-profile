module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
      when "comment" then
        @comment = Comment.find_by(id: @visitor_comment)
        image_tag @comment.post.image.url, class: "main-space__contents--title__image"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
