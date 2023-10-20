class TierListsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tier_list = TierList.new(tier_list_params)
    @tier_list.user_id = current_user.id
    if @tier_list.save
      redirect_to request.referer, notice: "TierListに追加しました"
    else
      redirect_to request.referer, alert: "TierListに追加できませんでした"
    end
  end

  def update
    @tier_list = TierList.find(params[:id])
    if @tier_list.update(tier_list_params)
      redirect_to request.referer, notice: "TierListを編集しました"
    else
      redirect_to request.referer, alert: "TierListを編集できませんでした"
    end
  end

  def destroy
    @tier_list = TierList.find(params[:id])
    @tier_list.destroy
    redirect_to request.referer, status: :see_other, notice: "TierListから削除しました"
  end

  def show
    @tier_list = TierList.find(params[:id])
  end

  private

    def tier_list_params
      params.require(:tier_list).permit(:animation_id, :tier_score, :comment, :spoiler)
    end
end
