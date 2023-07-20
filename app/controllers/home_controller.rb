class HomeController < ApplicationController
  def index
    base_scope = Album.includes(:artist).with_attached_cover

    @new_albums = base_scope.order(year: :desc).limit(5)
    @popular_albums = base_scope.order(listenings_count: :desc).limit(5)
    @recent_albums = current_user.recent_albums.merge(base_scope).limit(5) if current_user
    @live_stations = LiveStation.live.order(updated_at: :desc).limit(3)
  end
end
