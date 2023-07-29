class ArtistsController < ApplicationController
  def show
    artist = Artist.find(params[:id])
    albums = selected_albums(artist.albums, params[:album_type]).with_attached_cover.preload(:artist)

    if turbo_frame_request?
      render partial: "discography", locals: {artist:, albums:}
    else
      render action: :show, locals: {artist:, albums:}
    end
  end

  def load_more
    artist = Artist.find(params[:id])
    page = params[:page].to_i
    tracks = get_tracks(artist, page)
    next_page = tracks.length == 5 ? page + 1 : nil

    render partial: 'tracks/load_more', locals: {artist:, tracks:, page:, next_page:}
  end

  private

  def get_tracks(artist, page)
    artist.tracks.popularity_ordered.limit(5).offset(5 * page)
  end

  def selected_albums(albums, album_type)
    return albums.lp if album_type.blank?

    return albums.lp unless Album.kinds.key?(album_type)

    albums.where(kind: album_type)
  end
end
