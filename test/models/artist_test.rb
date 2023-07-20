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
end
