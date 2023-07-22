class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])

    if turbo_frame_request?
      render partial: "aside", locals: {album: @album}
    end
  end

  def play
    @album = Album.find(params[:id])

    render head: :ok
  end
end
