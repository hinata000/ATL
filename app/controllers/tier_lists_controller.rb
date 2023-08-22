class TierListsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tier_list = TierList.new(animation_id: params[:animation_id])
    @animation = Animation.find_by(id: params[:animation_id])
    session[:previous_url] = request.referer
  end

  def create
    @tier_list = TierList.new(tier_list_params)
    @tier_list.user_id = current_user.id
    if @tier_list.save
      redirect_to session[:previous_url], notice: "TierListに追加しました"
    else
      @animation = Animation.find_by(id: params[:animation_id])
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tier_list = TierList.find(params[:id])
    @animation = Animation.find_by(id: params[:animation_id])
    session[:previous_url] = request.referer
  end

  def update
    @tier_list = TierList.find(params[:id])
    if @tier_list.update(tier_list_params)
      redirect_to session[:previous_url], notice: "TierListを編集しました"
    else
      @animation = Animation.find(params[:id])
      render :edit
    end
  end

  def destroy
    @tier_list = TierList.find(params[:id])
    @tier_list.destroy
    redirect_to session[:previous_url], notice: "TierListから削除しました"
  end

  private

    def tier_list_params
      params.require(:tier_list).permit(:animation_id, :tier_score, :comment)
    end
end
