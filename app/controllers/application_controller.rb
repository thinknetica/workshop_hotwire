class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :current_track
  helper_method :current_album

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

    @current_track = Track.find_by(id: params[:track_id])
  end

  def current_album
    return @current_album if instance_variable_defined?(:@current_album)

    @current_album = Album.find_by(id: params[:album_id])
  end
end
