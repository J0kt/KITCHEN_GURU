class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :prep_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :cook_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :servings, numericality: { greater_than: 0 }, allow_nil: true
  validates :calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :difficulty, inclusion: { in: %w[facile moyen difficile] }, allow_nil: true
  validates :category, inclusion: { in: %w[petit-déjeuner déjeuner dîner snack] }, allow_nil: true

  scope :by_category, ->(cat) { where(category: cat) }
  scope :vegetarian, -> { where(is_vegetarian: true) }
  scope :vegan, -> { where(is_vegan: true) }
  scope :gluten_free, -> { where(is_gluten_free: true) }
  scope :quick_recipes, -> { where("prep_time + cook_time <= ?", 30) }

  def total_time
    (prep_time || 0) + (cook_time || 0)
  end

  def macros_summary
    {
      calories: calories,
      proteins: proteins,
      carbs: carbs,
      fats: fats,
      fiber: fiber
    }
  end
end
