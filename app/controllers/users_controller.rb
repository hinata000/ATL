class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [:mypage]

  def show
    @tier_list = @user.tier_lists
    @tier_list_entier = @user.tier_list_entiers
    @tier_list_mix = @tier_list | @tier_list_entier
    @tier_list_mix.sort!{ |a, b| b.created_at <=> a.created_at }

    @ss_tier = @user.tier_lists.where(tier_score: 5)
    @s_tier = @user.tier_lists.where(tier_score: 4)
    @a_tier = @user.tier_lists.where(tier_score: 3)
    @b_tier = @user.tier_lists.where(tier_score: 2)
    @c_tier = @user.tier_lists.where(tier_score: 1)

    @ss_tier_entier = @user.tier_list_entiers.where(tier_score: 5)
    @s_tier_entier = @user.tier_list_entiers.where(tier_score: 4)
    @a_tier_entier = @user.tier_list_entiers.where(tier_score: 3)
    @b_tier_entier = @user.tier_list_entiers.where(tier_score: 2)
    @c_tier_entier = @user.tier_list_entiers.where(tier_score: 1)
  end

  def mypage
    redirect_to user_path(current_user)
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
