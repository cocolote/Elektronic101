class Like < ActiveRecord::Base
  belongs_to :user

  validates :sc_track_id,
    presence: true

  validates :title,
    presence: true

  validates :duration,
    presence: true

  validates :stream_url,
    presence: true

  validates :user,
    presence: true
end
