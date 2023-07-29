class ApplicationController < ActionController::Base
  before_action :set_search

  def set_search
    @q = Animation.ransack(params[:q])
    @animations = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(16)
  end
end
