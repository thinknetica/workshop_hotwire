require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  test "names must be present and unique" do
    artist = Artist.new
    assert_not artist.valid?

    artist.name = "Red Hot Wires"
    assert artist.save!

    assert_raises(ActiveRecord::RecordInvalid) do
      Artist.create!(name: "Red Hot Wires")
    end
  end

  test ".tagged" do
    seattle_artists = Artist.tagged("seattle")
    assert_equal 1, seattle_artists.count
    assert_equal "Nirvana", artists.first.name

    rock_artists = Artist.tagged("rock")
    assert_equal 2, rock_artists.count
    assert_equal ["Metallica", "Nirvana"], rock_artists.order(name: :asc).pluck(:name)
  end
end
