class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  # A User must have one Profile (1:1), many Recipes (1:N), and many MealPlans (1:N)
  has_one :profile, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :meal_plans, dependent: :destroy
end
