class Tag < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :moments
  has_and_belongs_to_many :users

  # Validations ----------------------------------------------------------------
  validates :body, presence: true
end
