class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_name, :string, null: false
    add_column :users, :user_id, :string, null: false
    add_column :users, :user_image, :string, default: "user_icon_purple.png"

    add_index :users, :user_id, unique: true
  end
end
