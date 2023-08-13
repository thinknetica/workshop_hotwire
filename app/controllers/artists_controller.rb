class ArtistsController < ApplicationController
  helper_method :has_more_popular_tracks?

  def show
    @artist = Artist.find(params[:id])
    albums = selected_albums(@artist.albums, params[:album_type]).with_attached_cover.preload(:artist)
    tracks = @artist.popular_tracks.limit(popular_tracks_limit)

    if turbo_frame_request? && turbo_frame_request_id.include?("discography")
      render partial: "discography", locals: {artist: @artist, albums:}
    elsif turbo_frame_request? && turbo_frame_request_id.include?("popular-tracks")
      render action: :show, locals: {artist: @artist, albums:, tracks:}
    else
      render action: :show, locals: {artist: @artist, albums:, tracks:}
    end
  end

  private

  def selected_albums(albums, album_type)
    return albums.lp if album_type.blank?

    return albums.lp unless Album.kinds.key?(album_type)

    albums.where(kind: album_type)
  end

  def popular_tracks_limit
    (params[:popular_tracks_limit].presence || 5).to_i
  end

  def has_more_popular_tracks?
    @artist.popular_tracks.count > popular_tracks_limit
  end
end
