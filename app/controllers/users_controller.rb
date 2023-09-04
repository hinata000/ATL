class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @tier_list = @user.tier_lists
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
end
