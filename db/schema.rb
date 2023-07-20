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

ActiveRecord::Schema[7.1].define(version: 2023_07_20_183603) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "live_station_tracks", force: :cascade do |t|
    t.integer "live_station_id", null: false
    t.integer "track_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["live_station_id"], name: "index_live_station_tracks_on_live_station_id"
    t.index ["track_id"], name: "index_live_station_tracks_on_track_id"
  end

  create_table "live_stations", force: :cascade do |t|
    t.string "name"
    t.boolean "live", default: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_live_stations_on_user_id", unique: true
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "albums", "artists"
  add_foreign_key "listenings", "tracks"
  add_foreign_key "listenings", "users"
  add_foreign_key "live_station_tracks", "live_stations"
  add_foreign_key "live_station_tracks", "tracks"
  add_foreign_key "live_stations", "users"
  add_foreign_key "tracks", "albums"
end
