class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :ensure_normal_user, only: [:update, :destroy]

  def show
    @bookmarks = @user.bookmarks.order(created_at: :desc)

    @tier_lists = @user.tier_lists

    @q = Animation.joins(:tier_lists).where(tier_lists: { user_id: @user.id }).ransack(params[:q])
    @search_results = @q.result(distinct: true).order(created_at: :desc)

    @tier_list_new = TierList.new
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "アカウントを削除しました"
  end

  def mypage
    redirect_to user_path(current_user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def ensure_normal_user
      if @user.email == 'guest@example.com'
        redirect_to user_path, alert: 'ゲストユーザーの更新・削除はできません。'
      end
    end

    def user_params
      params.fetch(:user, {}).permit(:user_name, :user_id, :profile, :user_image, :header_image, :year, :season)
    end
end
