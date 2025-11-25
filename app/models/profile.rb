class Profile < ApplicationRecord
  belongs_to :user

  validates :gender, presence: true
  validates :age, presence: true, numericality: { greater_than: 0, less_than: 150 }
  validates :activity_level, presence: true
end
