class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.text :title, null: false

      t.integer :position, null: false
      t.integer :duration, null: false

      t.belongs_to :album, foreign_key: true, null: false

      t.integer :listenings_count, null: false, default: 0

      t.timestamps
    end
  end
end
