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

    redirect_to live_station_path
  end

  def stop
    station = current_user.live_station

    station.update!(live: false)

    redirect_to live_station_path
  end

  def update
    station = current_user.live_station
    station.update!(station_params)

    redirect_to live_station_path
  end

  def play
    station = LiveStation.find(params[:id])

    render partial: "shared/player", locals: {station:, track: station.current_track}
  end

  private

  def station_params
    params.require(:live_station).permit(:name, :cover)
  end
end
