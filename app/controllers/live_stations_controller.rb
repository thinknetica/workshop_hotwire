class LiveStationsController < ApplicationController
  before_action :authenticate

  def show
    @station = current_user.live_station

    if @station.nil?
      redirect_to new_live_station_path
      nil
    end
  end

  def new
    @station = current_user.build_live_station
  end

  def create
    @station = current_user.build_live_station(station_params)

    if @station.save
      redirect_to @station
    else
      render :new
    end
  end

  def edit
    @station = current_user.live_station
  end

  def start
    station = current_user.live_station

    station.update!(live: true)

    render turbo_stream: [
      turbo_stream.update("player", partial: "player/player", locals: {station:, track: station.current_track, live: true}),
      turbo_stream.replace(dom_id(station, :info), partial: "info", locals: {station:})
    ]
  end

  def stop
    station = current_user.live_station

    station.update!(live: false)

    Turbo::StreamsChannel.broadcast_update_to station, target: :player, content: ""

    render turbo_stream: [
      turbo_stream.update("player", inline: ""),
      turbo_stream.update(dom_id(station, :queue), partial: "queue", locals: {station:}),
      turbo_stream.replace(dom_id(station, :info), partial: "info", locals: {station:})
    ]

    station.reset_listeners
  end

  def play_next
    station = current_user.live_station

    track = station.play_next

    Turbo::StreamsChannel.broadcast_update_to station, target: :player, partial: "player/player", locals: {station:, track:}

    render turbo_stream: [
      turbo_stream.update("player", partial: "player/player", locals: {station:, track:, live: true}),
      turbo_stream.update(dom_id(station, :queue), partial: "live_stations/queue", locals: {station:})
    ]
  end

  def update
    station = current_user.live_station
    station.update!(station_params)

    redirect_to live_station_path
  end

  def play
    station = LiveStation.find(params[:id])

    render turbo_stream: turbo_stream.update("player", partial: "player/player", locals: {station:, track: station.current_track})
  end

  private

  def station_params
    params.require(:live_station).permit(:name, :cover)
  end
end
