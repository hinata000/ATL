class AnimationsController < ApplicationController
  def index
    @animations = Animation.all.order(created_at: :desc).page(params[:page]).per(16)
  end

  def show
    @animation = Animation.find_by(id: params[:id])
    @animations = Animation.where(id: params[:id])
    @animations_detail = AnimationDetail.where(animation_id: params[:id])
    @tier_lists = @animation.tier_list_entiers
    @tier_list = TierList.find_by(animation_id: params[:id])
    @tier_list_entiers = @animation.tier_lists
    @tier_list_entier = TierListEntier.find_by(animation_id: params[:id])

    @tier_list_mix = @tier_lists | @tier_list_entiers
    @tier_list_mix.sort!{ |a, b| b.created_at <=> a.created_at }
  end

  def search_results
  end
end
