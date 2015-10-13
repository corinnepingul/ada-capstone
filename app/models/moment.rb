class Moment < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :user
  has_and_belongs_to_many :tags

  # Validations ----------------------------------------------------------------
  validates :date, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
end
