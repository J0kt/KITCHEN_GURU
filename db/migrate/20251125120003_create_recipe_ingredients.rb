class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.decimal :quantity, precision: 8, scale: 2, null: false, comment: "Quantité de l'ingrédient"
      t.string :unit, null: false, comment: "Unité: g, ml, pièce, cuillère, etc."
      t.string :notes, comment: "Notes: émincé, haché, etc."

      t.timestamps
    end

    # Index composite pour éviter les doublons
    add_index :recipe_ingredients, [:recipe_id, :ingredient_id], unique: true
  end
end
