class TracksController < ApplicationController
  def play
    track = Track.find(params[:id])

    render turbo_stream: turbo_stream.update("player", partial: "player/player", locals: {track:})
  end

  def play_next
    track = Track.find(params[:id])

    @next_track = track.album.tracks.order(position: :asc).where("position > ?", track.position).first

    flash.now[:notice] = "You have reached the end of the album." unless @next_track
  end
end
