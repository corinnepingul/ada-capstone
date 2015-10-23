class User < ActiveRecord::Base
  has_secure_password
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :tags
  has_many :moments

  # Validations ----------------------------------------------------------------
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :phone_number, presence: true, uniqueness: true, length: { minimum: 10, maximum: 15 }
end
