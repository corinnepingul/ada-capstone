class User < ActiveRecord::Base
  # accepts numbers in format of: 111-111-1111, 111.111.1111,
  VALID_PHONE_REGEX = /(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]‌​)\s*)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)([2-9]1[02-9]‌​|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})/

  has_secure_password
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :tags
  has_many :moments

  # Validations ----------------------------------------------------------------
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :phone_number, presence: true, uniqueness: true, length: { minimum: 10, maximum: 15 }, format: { with: VALID_PHONE_REGEX }
end
