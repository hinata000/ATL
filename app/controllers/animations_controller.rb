class AnimationsController < ApplicationController

  before_action :set_tier_list, only: [:show, :search_results]

  def index
    @q = Animation.where.not(syobocal_tid: nil).ransack(params[:q])
    @animations = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(20)
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

    @tier_list_edit = TierList.find_by(animation_id: params[:id], user_id: current_user.id)
    @tier_list_entier_edit = TierListEntier.find_by(animation_id: params[:id], user_id: current_user.id)
  end

  private

    def set_tier_list
      @tier_list_new = TierList.new
      @tier_list_entier_new = TierListEntier.new
    end
end
