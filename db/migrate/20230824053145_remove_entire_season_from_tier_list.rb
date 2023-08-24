class RemoveEntireSeasonFromTierList < ActiveRecord::Migration[7.0]
  def change
    remove_column :tier_lists, :entire_season, :boolean
  end
end
