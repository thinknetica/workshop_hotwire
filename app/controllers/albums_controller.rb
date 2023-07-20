class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
  end

  def play
    @album = Album.find(params[:id])

    render head: :ok
  end
end
