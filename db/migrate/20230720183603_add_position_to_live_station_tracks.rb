class AddPositionToLiveStationTracks < ActiveRecord::Migration[7.1]
  def change
    add_column :live_station_tracks, :position, :integer
  end
end
