class AddColumnBookmark < ActiveRecord::Migration[7.0]
  def change
    add_index :bookmarks, [:animation_id, :user_id], unique: true
  end
end
