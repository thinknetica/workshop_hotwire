require "test_helper"

class ListeningTest < ActiveSupport::TestCase
  test "artist, album and track listenings counter cache" do
    track = tracks(:smells_like)
    artist = artists(:nirvana)
    album = albums(:nevermind)
    user = users(:penny)

    assert_difference(-> { artist.reload.listenings_count }, 1) do
      assert_difference(-> { album.reload.listenings_count }, 1) do
        assert_difference(-> { track.reload.listenings_count }, 1) do
          track.listenings.create!(user: user)
        end
      end
    end
  end
end
