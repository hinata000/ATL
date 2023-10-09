class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:mypage, :edit, :update]
  before_action :ensure_normal_user, only: [:update, :destroy]

  def show
    @bookmarks = @user.bookmarks.order(created_at: :desc)

    @tier_list = @user.tier_lists
    @tier_list_entier = @user.tier_list_entiers
    @tier_list_mix = @tier_list | @tier_list_entier
    @tier_list_mix.sort!{ |a, b| b.created_at <=> a.created_at }

    @q = Animation.joins(:tier_lists).where(tier_lists: { user_id: @user.id }).ransack(params[:q])
    @tier_lists = @q.result(distinct: true).order(created_at: :desc)
    @tier_list_entiers = Animation.joins(:tier_list_entiers).where(tier_list_entiers: { user_id: @user.id })

    @tier_list_new = TierList.new
    @tier_list_entier_new = TierListEntier.new
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
