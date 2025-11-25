class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  # A User must have one Profile (1:1) and many Recipes (1:N)
  has_one :profile, dependent: :destroy
  has_many :recipes, dependent: :destroy
end
