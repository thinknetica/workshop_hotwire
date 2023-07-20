require "test_helper"

class TrackTest < ActiveSupport::TestCase
  test "artist and album counter cache" do
    artist = artists(:nirvana)
    album = albums(:nevermind)

    assert_difference(-> { artist.reload.tracks_count }, 1) do
      assert_difference(-> { album.reload.tracks_count }, 1) do
        album.tracks.create!(title: "In Bloom", position: 3, duration: 178)
      end
    end
  end
end
