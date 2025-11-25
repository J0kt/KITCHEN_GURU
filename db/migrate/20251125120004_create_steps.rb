class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.references :recipe, null: false, foreign_key: true
      t.integer :step_number, null: false, comment: "Numéro de l'étape (ordre)"
      t.text :instruction, null: false, comment: "Description de l'étape"
      t.integer :duration_minutes, comment: "Durée estimée de l'étape en minutes"
      t.string :image_url, comment: "Image optionnelle de l'étape"

      t.timestamps
    end

    # Index pour ordonner les étapes par recette
    add_index :steps, [:recipe_id, :step_number], unique: true
  end
end
