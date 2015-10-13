class Tag < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :moments, :users

  # Validations ----------------------------------------------------------------

end
