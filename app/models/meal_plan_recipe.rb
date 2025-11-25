class MealPlanRecipe < ApplicationRecord
  belongs_to :meal_plan
  belongs_to :recipe

  # Optionnel : type de repas (breakfast/lunch/dinner)
  validates :meal_type, presence: true
end
