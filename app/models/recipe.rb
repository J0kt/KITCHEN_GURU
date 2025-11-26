# # class Recipe < ApplicationRecord

# #   # Associations
# #   belongs_to :user
# #   has_many :recipe_ingredients, dependent: :destroy
# #   has_many :ingredients, through: :recipe_ingredients
# #   has_many :steps, -> { order(step_number: :asc) }, dependent: :destroy
# #   has_many :meal_plan_entries, dependent: :destroy
# #   has_many :meal_plans, through: :meal_plan_entries

# #   # Validations
# #   validates :title, presence: true, length: { minimum: 3, maximum: 200 }
# #   validates :prep_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
# #   validates :cook_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
# #   validates :servings, numericality: { greater_than: 0 }, allow_nil: true
# #   validates :calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
# #   validates :difficulty, inclusion: { in: %w[facile moyen difficile] }, allow_nil: true
# #   validates :category, inclusion: { in: %w[petit-déjeuner déjeuner dîner snack] }, allow_nil: true

# #   # Scopes
# #   scope :by_category, ->(cat) { where(category: cat) }
# #   scope :vegetarian, -> { where(is_vegetarian: true) }
# #   scope :vegan, -> { where(is_vegan: true) }
# #   scope :gluten_free, -> { where(is_gluten_free: true) }
# #   scope :quick_recipes, -> { where("prep_time + cook_time <= ?", 30) }

# #   # Méthodes
# #   def total_time
# #     (prep_time || 0) + (cook_time || 0)
# #   end

# #   def macros_summary
# #     {
# #       calories: calories,
# #       proteins: proteins,
# #       carbs: carbs,
# #       fats: fats,
# #       fiber: fiber
# #     }
# #   end
# # end

# class Recipe < ApplicationRecord
#   # Associations
#   belongs_to :user

#   # For predemo, we disable associations that rely on models
#   # which are not fully implemented yet (to avoid NameError on destroy).
#   # has_many :recipe_ingredients, dependent: :destroy
#   # has_many :ingredients, through: :recipe_ingredients
#   # has_many :steps, -> { order(step_number: :asc) }, dependent: :destroy
#   # has_many :meal_plan_entries, dependent: :destroy
#   # has_many :meal_plans, through: :meal_plan_entries

#   # Validations
#   validates :title, presence: true, length: { minimum: 3, maximum: 200 }
#   validates :prep_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
#   validates :cook_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
#   validates :servings, numericality: { greater_than: 0 }, allow_nil: true
#   validates :calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
#   validates :difficulty, inclusion: { in: %w[facile moyen difficile] }, allow_nil: true
#   validates :category, inclusion: { in: %w[petit-déjeuner déjeuner dîner snack] }, allow_nil: true

#   # Scopes
#   scope :by_category, ->(cat) { where(category: cat) }
#   scope :vegetarian, -> { where(is_vegetarian: true) }
#   scope :vegan, -> { where(is_vegan: true) }
#   scope :gluten_free, -> { where(is_gluten_free: true) }
#   scope :quick_recipes, -> { where("prep_time + cook_time <= ?", 30) }

#   # Methods
#   def total_time
#     (prep_time || 0) + (cook_time || 0)
#   end

#   def macros_summary
#     {
#       calories: calories,
#       proteins: proteins,
#       carbs: carbs,
#       fats: fats,
#       fiber: fiber
#     }
#   end
# end

class Recipe < ApplicationRecord
  # Associations
  belongs_to :user

  # For predemo, we disable associations that rely on models
  # which are not fully implemented yet (to avoid NameError on destroy).
  # has_many :recipe_ingredients, dependent: :destroy
  # has_many :ingredients, through: :recipe_ingredients
  # has_many :steps, -> { order(step_number: :asc) }, dependent: :destroy
  # has_many :meal_plan_entries, dependent: :destroy
  # has_many :meal_plans, through: :meal_plan_entries

  # Validations
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :prep_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :cook_time, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :servings, numericality: { greater_than: 0 }, allow_nil: true
  validates :calories, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :difficulty, inclusion: { in: %w[facile moyen difficile] }, allow_nil: true
  validates :category, inclusion: { in: %w[petit-déjeuner déjeuner dîner snack] }, allow_nil: true

  # Scopes
  scope :by_category, ->(cat) { where(category: cat) }
  scope :vegetarian, -> { where(is_vegetarian: true) }
  scope :vegan, -> { where(is_vegan: true) }
  scope :gluten_free, -> { where(is_gluten_free: true) }
  scope :quick_recipes, -> { where("prep_time + cook_time <= ?", 30) }

  # Methods
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
