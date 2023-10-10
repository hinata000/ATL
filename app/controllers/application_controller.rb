class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :set_notification
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_search
    @q = Animation.where.not(syobocal_tid: nil).ransack(params[:q])
    @animations = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(20)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:user_name, :user_id, :profile, :user_image, :header_image])
  end

  def set_notification
    if user_signed_in?
      @notifications = current_user.passive_notifications.order(created_at: :DESC).limit(5)
    end
  end
end
