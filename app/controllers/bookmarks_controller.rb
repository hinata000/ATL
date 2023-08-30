class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = Bookmark.new(user_id: current_user.id, animation_id: params[:animation_id])
    @bookmark.save
    redirect_to animation_path(params[:animation_id])
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, animation_id: params[:animation_id])
    @bookmark.destroy
    redirect_to animation_path(params[:animation_id])
  end
end
