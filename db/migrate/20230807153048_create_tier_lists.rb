class CreateTierLists < ActiveRecord::Migration[7.0]
  def change
    create_table :tier_lists do |t|
      t.references :animation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :tier_score, null: false
      t.text :comment

      t.timestamps
    end
  end
end
