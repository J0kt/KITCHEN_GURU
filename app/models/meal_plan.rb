class MealPlan < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :meal_plan_entries, dependent: :destroy
  has_many :recipes, through: :meal_plan_entries

  # Validations
  validates :week_start_date, presence: true
  validates :target_kcal, numericality: { greater_than: 0 }, allow_nil: true
  validates :total_cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :for_week, ->(date) { where(week_start_date: date.beginning_of_week) }
  scope :recent, -> { order(week_start_date: :desc) }

  # Jours de la semaine en français
  DAYS = {
    0 => 'Lundi',
    1 => 'Mardi',
    2 => 'Mercredi',
    3 => 'Jeudi',
    4 => 'Vendredi',
    5 => 'Samedi',
    6 => 'Dimanche'
  }.freeze

  # Méthode pour obtenir les repas d'un jour spécifique
  def meals_for_day(day_index)
    meal_plan_entries.where(day_of_week: day_index).includes(:recipe)
  end

  # Méthode pour calculer les calories totales du plan
  def calculate_total_calories
    recipes.sum(:calories)
  end

  # Méthode pour calculer le coût total
  def calculate_total_cost
    recipes.sum(:estimated_cost)
  end

  # Méthode pour générer le nom par défaut
  def default_name
    "Plan du #{week_start_date.strftime('%d %B %Y')}"
  end
end
