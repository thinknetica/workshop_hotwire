class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :year, null: false
      t.string :kind, null: false, default: "lp", index: true

      t.belongs_to :artist, foreign_key: true, null: false

      t.integer :tracks_count, null: false, default: 0
      t.integer :listenings_count, null: false, default: 0

      t.timestamps
    end
  end
end
