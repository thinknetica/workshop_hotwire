class CreateLiveStationTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :live_station_tracks do |t|
      t.belongs_to :live_station, foreign_key: true, null: false
      t.belongs_to :track, foreign_key: true, null: false

      t.timestamps
    end
  end
end
