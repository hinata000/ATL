class AddColumnAnimations < ActiveRecord::Migration[7.0]
  def change
    add_column :animations, :bookmarks_count, :integer, null: false, default: 0
    add_column :animations, :tier_average, :float, default: 0.0
  end
end
