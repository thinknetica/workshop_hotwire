# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_07_20_020936) do
  create_table "albums", force: :cascade do |t|
    t.string "title", null: false
    t.integer "year", null: false
    t.string "kind", default: "lp", null: false
    t.integer "artist_id", null: false
    t.integer "tracks_count", default: 0, null: false
    t.integer "listenings_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_albums_on_artist_id"
    t.index ["kind"], name: "index_albums_on_kind"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name", null: false
    t.text "bio"
    t.integer "albums_count", default: 0, null: false
    t.integer "tracks_count", default: 0, null: false
    t.integer "listenings_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "tags"
    t.index ["name"], name: "index_artists_on_name", unique: true
  end

  create_table "listenings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["track_id"], name: "index_listenings_on_track_id"
    t.index ["user_id"], name: "index_listenings_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.text "title", null: false
    t.integer "position", null: false
    t.integer "duration", null: false
    t.integer "album_id", null: false
    t.integer "listenings_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_tracks_on_album_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "albums", "artists"
  add_foreign_key "listenings", "tracks"
  add_foreign_key "listenings", "users"
  add_foreign_key "tracks", "albums"
end
