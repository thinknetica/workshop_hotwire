class CreateLiveStations < ActiveRecord::Migration[7.1]
  def change
    create_table :live_stations do |t|
      t.string :name
      t.boolean :live, default: false

      t.belongs_to :user, foreign_key: true, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
