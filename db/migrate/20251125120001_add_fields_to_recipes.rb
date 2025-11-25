class AddFieldsToRecipes < ActiveRecord::Migration[7.1]
  def change
    # Ajout des champs nutritionnels
    add_column :recipes, :calories, :integer, comment: "Calories par portion (kcal)"
    add_column :recipes, :proteins, :decimal, precision: 6, scale: 2, comment: "Protéines en grammes"
    add_column :recipes, :carbs, :decimal, precision: 6, scale: 2, comment: "Glucides en grammes"
    add_column :recipes, :fats, :decimal, precision: 6, scale: 2, comment: "Lipides en grammes"
    add_column :recipes, :fiber, :decimal, precision: 6, scale: 2, comment: "Fibres en grammes"

    # Métadonnées supplémentaires
    add_column :recipes, :difficulty, :string, default: "facile", comment: "Niveau: facile, moyen, difficile"
    add_column :recipes, :image_url, :string, comment: "URL de l'image de la recette"
    add_column :recipes, :estimated_cost, :decimal, precision: 6, scale: 2, comment: "Coût estimé en euros"
    add_column :recipes, :category, :string, comment: "Catégorie: petit-déjeuner, déjeuner, dîner, snack"
    add_column :recipes, :cuisine_type, :string, comment: "Type de cuisine: française, italienne, etc."
    add_column :recipes, :is_vegetarian, :boolean, default: false
    add_column :recipes, :is_vegan, :boolean, default: false
    add_column :recipes, :is_gluten_free, :boolean, default: false

    # Index pour les recherches fréquentes
    add_index :recipes, :category
    add_index :recipes, :difficulty
  end
end
