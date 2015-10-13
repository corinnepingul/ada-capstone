class User < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :tags
  has_many :moments

  # Validations ----------------------------------------------------------------
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :phone_number, presence: true, uniqueness: true
end
