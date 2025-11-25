class RecipeIngredient < ApplicationRecord
  # Associations
  belongs_to :recipe
  belongs_to :ingredient

  # Validations
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true
  validates :recipe_id, uniqueness: { scope: :ingredient_id, message: "cet ingrédient existe déjà dans la recette" }

  # Unités disponibles
  UNITS = %w[g kg ml l pièce cuillère-à-soupe cuillère-à-café tasse pincée].freeze

  validates :unit, inclusion: { in: UNITS }

  # Méthode pour afficher l'ingrédient formaté
  def display_name
    "#{quantity} #{unit} #{ingredient.name}#{notes.present? ? " (#{notes})" : ''}"
  end
end
