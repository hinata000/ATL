class TierListEntiersController < ApplicationController
  before_action :authenticate_user!

  def new
    @tier_list_entier = TierListEntier.new(animation_id: params[:animation_id])
    @animation = Animation.find_by(id: params[:animation_id])
    session[:previous_url] = request.referer
  end

  def create
    @tier_list_entier = TierListEntier.new(tier_list_entier_params)
    @tier_list_entier.user_id = current_user.id
    if @tier_list_entier.save
      redirect_to session[:previous_url], notice: "TierListに追加しました"
    else
      @animation = Animation.find_by(id: params[:animation_id])
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @tier_list_entier = TierListEntier.find(params[:id])
    @animation = Animation.find_by(id: params[:animation_id])
    session[:previous_url] = request.referer
  end

  def update
    @tier_list_entier = TierListEntier.find(params[:id])
    if @tier_list_entier.update(tier_list_entier_params)
      redirect_to session[:previous_url], notice: "TierListを編集しました"
    else
      @animation = Animation.find(params[:id])
      render :edit
    end
  end

  def destroy
    @tier_list_entier = TierListEntier.find(params[:id])
    @tier_list_entier.destroy
    redirect_to session[:previous_url], notice: "TierListから削除しました"
  end

  private

    def tier_list_entier_params
      params.require(:tier_list_entier).permit(:animation_id, :tier_score, :comment, :spoiler)
    end
end
