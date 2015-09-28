class User < ActiveRecord::Base
  has_many :likes

  validates :sc_user_id,
    presence: true

  validates :access_token,
    presence: true

  validates :refresh_token,
    presence: true

end
