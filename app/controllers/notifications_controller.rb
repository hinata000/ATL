class NotificationsController < ApplicationController

  def index
    if user_signed_in?
      @notifications = current_user.passive_notifications.order(created_at: :DESC).limit(5)
      @notifications.where(checked: false).each do |notification|
        notification.update(checked: true)
      end
    end
  end

end
