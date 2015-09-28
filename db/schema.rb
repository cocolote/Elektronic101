# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150924013244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "likes", force: :cascade do |t|
    t.integer  "sc_track_id", null: false
    t.string   "title",       null: false
    t.string   "artwork_url"
    t.string   "username"
    t.integer  "duration",    null: false
    t.string   "stream_url",  null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "sc_user_id",                          null: false
    t.string   "access_token",                        null: false
    t.string   "refresh_token",                       null: false
    t.string   "username",                            null: false
    t.string   "avatar"
    t.string   "country"
    t.string   "city"
    t.integer  "track_count",             default: 0
    t.integer  "playlist_count",          default: 0
    t.integer  "favorites_count",         default: 0
    t.integer  "followers_count",         default: 0
    t.integer  "following_count",         default: 0
    t.integer  "private_tracks_count",    default: 0
    t.integer  "private_playlists_count", default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
