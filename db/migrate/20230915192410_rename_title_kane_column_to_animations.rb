class RenameTitleKaneColumnToAnimations < ActiveRecord::Migration[7.0]
  def change
    rename_column :animations, :title_kane, :title_kana
  end
end
