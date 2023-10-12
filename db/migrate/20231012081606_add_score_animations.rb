class AddScoreAnimations < ActiveRecord::Migration[7.0]
  def change
    add_column :animations, :score, :float, default: 0.0, null: false
  end
end
