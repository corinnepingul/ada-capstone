class Moment < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  belongs_to :user
  has_and_belongs_to_many :tags

  # Validations ----------------------------------------------------------------
  validates :date, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  # Scopes ---------------------------------------------------------------------
  scope :user, -> (user_id) { where(user_id: user_id) }
  scope :search_body, -> (search_term) { where("body LIKE ?", "%#{search_term}%") }
end
