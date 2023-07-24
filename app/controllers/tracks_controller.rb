class TracksController < ApplicationController
  def play
    track = Track.find(params[:id])

    session[:track_id] = track.id

    render partial: "shared/player", locals: {track:}
  end

  def play_next
    track = Track.find(params[:id])

    # Make sure we do not cache the request
    expires_now

    next_track = track.album.tracks.order(position: :asc).where("position > ?", track.position).first

    session[:track_id] = next_track.id if next_track

    render partial: "shared/player", locals: {track: next_track}
  end
end
