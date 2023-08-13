class TracksController < ApplicationController
  helper_method :current_page, :has_next_page?, :next_page

  def index
    @artist = Artist.find(params[:artist_id])
    tracks = @artist.tracks.offset(current_page * per_page).limit(per_page)

    if turbo_frame_request? && turbo_frame_request_id.include?("tracks")
      render partial: "tracks", locals: {artist: @artist, tracks:}
    else
      render action: :index, locals: {artist: @artist, tracks:}
    end
  end

  private

  def per_page
    10
  end

  def current_page
    (params[:page] || 1).to_i
  end

  def has_next_page?
    current_page * 10 < @artist.tracks.size
  end

  def next_page
    current_page + 1
  end
end
