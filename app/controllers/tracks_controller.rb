class TracksController < ApplicationController
  def index
    artist = Artist.find(params[:artist_id])

    render action: :index, locals: {artist:}
  end
end
