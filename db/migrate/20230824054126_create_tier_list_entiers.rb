class CreateTierListEntiers < ActiveRecord::Migration[7.0]
  def change
    create_table :tier_list_entiers do |t|
      t.integer :tier_score, null: false
      t.text :comment
      t.boolean :spoiler, null: false
      t.references :animation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :tier_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
