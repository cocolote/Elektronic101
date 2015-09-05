class User < ActiveRecord::Base

  validates :sc_user_id,
    presence: true

  validates :access_token,
    presence: true

  validates :refresh_token,
    presence: true

end
