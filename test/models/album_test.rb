require "test_helper"

class AlbumTest < ActiveSupport::TestCase
  test "artist counter cache" do
    artist = artists(:beatles)

    assert_difference(-> { artist.reload.albums_count }, 1) do
      artist.albums.create!(title: "Abbey Road", year: 1969)
    end
  end
end
