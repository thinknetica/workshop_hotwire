# frozen_string_literal: true

class LiveStationTrack < ApplicationRecord
  belongs_to :track
  belongs_to :live_station
end
