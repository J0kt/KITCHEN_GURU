class MealPlanEntry < ApplicationRecord
  # Associations
  belongs_to :meal_plan
  belongs_to :recipe

  # Validations
  validates :day_of_week, presence: true,
                          inclusion: { in: 0..6, message: "doit être entre 0 (Lundi) et 6 (Dimanche)" }
  validates :meal_type, presence: true,
                        inclusion: { in: %w[petit-déjeuner déjeuner dîner snack] }
  validates :meal_plan_id, uniqueness: {
    scope: [:day_of_week, :meal_type],
    message: "un repas de ce type existe déjà pour ce jour"
  }

  # Types de repas
  MEAL_TYPES = %w[petit-déjeuner déjeuner dîner snack].freeze

  # Méthode pour obtenir le nom du jour
  def day_name
    MealPlan::DAYS[day_of_week]
  end

  # Méthode pour formater l'affichage
  def display_name
    "#{day_name} - #{meal_type.capitalize}: #{recipe.title}"
  end
end
