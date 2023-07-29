class CreateAnimations < ActiveRecord::Migration[7.0]
  def change
    create_table :animations do |t|
      t.string :title
      t.integer :year
      t.integer :season
      t.string :image
      t.string :twitter_username
      t.string :official_site_url
      t.string :media_text
      t.string :season_name_text
      t.integer :syobocal_tid

      t.timestamps
    end
  end
end
