class ListenerChannel < ApplicationCable::Channel
  def subscribed
    station = LiveStation.find(params[:id])
    stream_from "listener-#{station}" if station

    station.add_listener!!
    Turbo::StreamsChannel.broadcast_replace_to "station-#{station.id}-listeners", target: "player_listeners", content: broadcast_station(station)
  end

  def unsubscribed
    station = LiveStation.find(params[:id])
    station.add_listener!(-1)

    Turbo::StreamsChannel.broadcast_replace_to "station-#{station.id}-listeners", target: "player_listeners", content: broadcast_station(station)
  end

  private

  def broadcast_station(station)
    ApplicationController.renderer.render(
      partial: "player/listeners",
      locals: { station: station }
    )
  end
end
