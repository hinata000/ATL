class RemoveTierListIdFromTierListEntiers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :tier_list_entiers, :tier_list, null: false, foreign_key: true
  end
end
