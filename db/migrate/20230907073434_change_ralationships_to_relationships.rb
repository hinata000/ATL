class ChangeRalationshipsToRelationships < ActiveRecord::Migration[7.0]
  def change
    rename_table :ralationships, :relationships
  end
end
