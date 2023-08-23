class AddColumnsToTierLists < ActiveRecord::Migration[7.0]
  def change
    add_column :tier_lists, :spoiler, :boolean, null: false
    add_column :tier_lists, :entire_season, :boolean, null: false
  end
end
