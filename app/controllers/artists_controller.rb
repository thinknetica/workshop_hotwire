class ArtistsController < ApplicationController
  def show
    artist = Artist.find(params[:id])
    albums = selected_albums(artist.albums, params[:album_type]).with_attached_cover.preload(:artist)
    tracks = artist.tracks.popularity_ordered.limit(5)

    if turbo_frame_request?
      render partial: "discography", locals: {artist:, albums:}
    else
      render action: :show, locals: {artist:, albums:, tracks:}
    end
  end

  def tracks
    artist = Artist.find(params[:id])
    albums = selected_albums(artist.albums, params[:album_type]).with_attached_cover.preload(:artist)
    tracks = artist.tracks.popularity_ordered

    if turbo_frame_request?
      render partial: "tracks", locals: {artist:, tracks:}
    else
      render action: :show, locals: {artist:, albums:, tracks:}
    end
  end

  private

  def selected_albums(albums, album_type)
    return albums.lp if album_type.blank?

    return albums.lp unless Album.kinds.key?(album_type)

    albums.where(kind: album_type)
  end
end
