class ArtistsController < ApplicationController
  def show
    artist = Artist.find(params[:id])
    albums = selected_albums(artist.albums, params[:album_type]).with_attached_cover.preload(:artist)
    tracks = artist.tracks.popularity_ordered.limit(select_limit(params[:tracks_number]))

    if turbo_frame_request?
      if params[:tracks_number].present?
        render partial: "tracks", locals: {artist:, tracks:}
      else
        render partial: "discography", locals: {artist:, albums:}
      end
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

  def select_limit(tracks_number)
    tracks_count = tracks_number.to_i + 5

    tracks_count > 20 ? 20 : tracks_count
  end
end
