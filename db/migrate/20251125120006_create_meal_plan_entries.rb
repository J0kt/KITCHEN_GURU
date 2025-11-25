class CreateMealPlanEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_plan_entries do |t|
      t.references :meal_plan, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :day_of_week, null: false, comment: "0=Lundi, 1=Mardi, ..., 6=Dimanche"
      t.string :meal_type, null: false, comment: "petit-déjeuner, déjeuner, dîner, snack"

      t.timestamps
    end

    # Un seul repas par type par jour dans un plan
    add_index :meal_plan_entries, [:meal_plan_id, :day_of_week, :meal_type],
              unique: true, name: 'idx_unique_meal_per_day'
  end
end
