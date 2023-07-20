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

    @current_track = params[:track_id].present? ? Track.find_by(id: params[:track_id]) : nil
  end

  def current_album
    return @current_album if instance_variable_defined?(:@current_album)

    @current_album = params[:album_id].present? ? Album.find_by(id: params[:album_id]) : nil
  end

  def current_station
    return @current_station if instance_variable_defined?(:@current_station)

    @current_station = params[:station_id].present? ? LiveStation.find_by(id: params[:station_id]) : nil
  end
end
