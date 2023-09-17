class AddMediaAnimations < ActiveRecord::Migration[7.0]
  def change
    add_column :animations, :media, :string
    remove_column :animations, :released_on, :string
  end
end
