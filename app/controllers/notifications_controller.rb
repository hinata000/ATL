class NotificationsController < ApplicationController

  def index
    if user_signed_in?
      @notifications = current_user.passive_notifications.order(created_at: :DESC).page(params[:page]).per(15)
      @notifications.where(checked: false).find_each do |notification|
        notification.update(checked: true)
      end
    end
  end

end
