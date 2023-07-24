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

    session[:track_id] = station.current_track&.id
    session[:station_id] = station.id

    station.update!(live: true)

    redirect_to station
  end

  def stop
    station = current_user.live_station

    session.delete(:track_id)
    session.delete(:station_id)
    station.update!(live: false)

    redirect_to station
  end

  def update
    @station = current_user.live_station
    @station.update!(station_params)
    redirect_to @station
  end

  private

  def station_params
    params.require(:live_station).permit(:name, :cover)
  end
end
