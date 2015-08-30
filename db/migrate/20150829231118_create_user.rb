class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :sc_user_id,              null: false
      t.string  :access_token,            null: false
      t.string  :refresh_token,           null: false
      t.string  :username,                null: false
      t.string  :avatar
      t.string  :country
      t.string  :city
      t.integer :track_count,             default: 0
      t.integer :playlist_count,          default: 0
      t.integer :favorites_count,         default: 0
      t.integer :followers_count,         default: 0
      t.integer :following_count,         default: 0
      t.integer :private_tracks_count,    default: 0
      t.integer :private_playlists_count, default: 0

      t.timestamps null: false
    end
  end
end
