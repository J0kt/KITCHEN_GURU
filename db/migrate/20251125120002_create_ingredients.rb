class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false, comment: "Nom de l'ingrédient"
      t.string :category, comment: "Catégorie: légumes, fruits, viandes, etc."
      t.string :default_unit, default: "g", comment: "Unité par défaut"
      t.integer :calories_per_100g, comment: "Calories pour 100g"
      t.decimal :proteins_per_100g, precision: 6, scale: 2
      t.decimal :carbs_per_100g, precision: 6, scale: 2
      t.decimal :fats_per_100g, precision: 6, scale: 2

      t.timestamps
    end

    add_index :ingredients, :name, unique: true
    add_index :ingredients, :category
  end
end
