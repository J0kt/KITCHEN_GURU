class Recipe < ApplicationRecord
  # Associations
  # A Recipe belongs to one User (1:N)
  belongs_to :user
end
