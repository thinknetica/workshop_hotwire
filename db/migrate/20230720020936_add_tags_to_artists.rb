class AddTagsToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :tags, :json
  end
end
