class CreateListenings < ActiveRecord::Migration[7.1]
  def change
    create_table :listenings do |t|
      t.belongs_to :user, foreign_key: true, null: false, index: true
      t.belongs_to :track, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
