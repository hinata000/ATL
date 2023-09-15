class ApplicationController < ActionController::Base
  before_action :set_search
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_search
    @search_word = params[:q][:title_or_title_kana_cont] if params[:q]
    @q = Animation.ransack(params[:q])
    @animations = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(16)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:user_name, :user_id, :profile, :user_image, :header_image])
  end
end
