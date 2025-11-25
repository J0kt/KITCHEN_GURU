class CreateMealPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, comment: "Nom du plan (ex: 'Semaine du 25 novembre')"
      t.date :week_start_date, null: false, comment: "Date de début de la semaine"
      t.integer :target_kcal, comment: "Objectif calorique quotidien"
      t.decimal :total_cost, precision: 8, scale: 2, comment: "Coût total estimé"
      t.text :diversity_summary, comment: "Résumé de la diversité alimentaire"
      t.boolean :is_active, default: true, comment: "Plan actif/archivé"

      t.timestamps
    end

    add_index :meal_plans, [:user_id, :week_start_date]
    add_index :meal_plans, :is_active
  end
end
