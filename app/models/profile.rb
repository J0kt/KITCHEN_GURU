class Profile < ApplicationRecord
  # Associations
  # A Profile belongs to one User (1:1)
  belongs_to :user
end
