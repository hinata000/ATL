class AddColumnsAnimations < ActiveRecord::Migration[7.0]
  def change
    add_column :animations, :title_kane, :string
    add_column :animations, :released_on, :string
  end
end
