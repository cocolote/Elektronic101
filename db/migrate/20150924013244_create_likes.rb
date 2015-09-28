class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :sc_track_id, null: false
      t.string  :title,       null: false
      t.string  :artwork_url
      t.string  :username
      t.integer :duration,    null: false
      t.string  :stream_url,  null: false
      t.integer :user_id,     null: false

      t.timestamps null: false
    end
  end
end
