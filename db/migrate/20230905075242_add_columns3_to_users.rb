class AddColumns3ToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :header_image, :string, default: "user_header.png"
    add_column :users, :profile, :text
  end
end
