class CreateAnimationDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :animation_details do |t|
      t.integer :animation_id
      t.text :staffs
      t.text :casts
      t.integer :syobocal_tid

      t.timestamps
    end
  end
end
