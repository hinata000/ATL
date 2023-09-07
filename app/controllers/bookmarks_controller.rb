class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = Bookmark.new(user_id: current_user.id, animation_id: params[:animation_id])
    @bookmark.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, animation_id: params[:animation_id])
    @bookmark.destroy
    redirect_back(fallback_location: root_path)
  end
end
