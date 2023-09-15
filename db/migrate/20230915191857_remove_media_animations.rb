class RemoveMediaAnimations < ActiveRecord::Migration[7.0]
  def change
    remove_column :animations, :media, :string
  end
end
