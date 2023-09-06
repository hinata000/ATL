class ChangeColumnUser < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :user_image, nil
    change_column_default :users, :header_image, nil
  end
end
