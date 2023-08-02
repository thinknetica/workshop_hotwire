class ListenersCountChannel < ApplicationCable::Channel
  after_subscribe :increase_listeners_count
  after_unsubscribe :decrease_listeners_count

  def subscribed
    return unless params[:station]

    stream_from channel_name
  end

  def unsubscribed
    return unless params[:station]

    stop_stream_from channel_name
  end

  private

  def increase_listeners_count
    station.update_listeners_count(station.listeners_online + 1)
    ActionCable.server.broadcast(channel_name, { count: station.listeners_online })
  end

  def decrease_listeners_count
    station.update_listeners_count(station.listeners_online - 1)
    ActionCable.server.broadcast(channel_name, { count: station.listeners_online })
  end

  def station
    @station ||= LiveStation.find(params[:station])
  end

  def channel_name
    @channel_name ||= "listener-channel-#{station.id}"
  end
end
