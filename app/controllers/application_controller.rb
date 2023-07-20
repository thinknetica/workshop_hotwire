class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_track
  helper_method :current_album
  helper_method :current_station

  private

  def authenticate
    redirect_to sign_in_path unless current_user
  end

  def current_user
    return @current_user if instance_variable_defined?(:@current_user)

    @current_user = User.find_by(id: cookies.signed[:user_id])
  end

  def current_track
    return @current_track if instance_variable_defined?(:@current_track)

    track_id = params[:track_id] || session[:track_id]
    @current_track = track_id.present? ? Track.find_by(id: track_id) : nil
    session[:track_id] = @current_track&.id
    @current_track
  end

  def current_album
    return @current_album if instance_variable_defined?(:@current_album)

    album_id = params[:album_id] || session[:album_id]
    @current_album = album_id.present? ? Album.find_by(id: album_id) : nil

    session[:album_id] = @current_album&.id
    @current_album
  end

  def current_station
    return @current_station if instance_variable_defined?(:@current_station)

    station_id = params[:station_id] || session[:station_id]

    @current_station = station_id.present? ? LiveStation.find_by(id: station_id) : nil
    session[:station_id] = @current_station&.id
    @current_station
  end
end
