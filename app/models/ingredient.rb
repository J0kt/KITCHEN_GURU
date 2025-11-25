class Ingredient < ApplicationRecord
  # Associations
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, inclusion: {
    in: %w[légumes fruits viandes poissons produits-laitiers céréales légumineuses épices huiles autres]
  }, allow_nil: true
  validates :calories_per_100g, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Scopes
  scope :by_category, ->(cat) { where(category: cat) }
  scope :search_by_name, ->(query) { where("name ILIKE ?", "%#{query}%") }

  # Catégories disponibles
  CATEGORIES = %w[
    légumes
    fruits
    viandes
    poissons
    produits-laitiers
    céréales
    légumineuses
    épices
    huiles
    autres
  ].freeze
end
