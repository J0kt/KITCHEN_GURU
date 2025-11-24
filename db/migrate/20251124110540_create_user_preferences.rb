class CreateUserPreferences < ActiveRecord::Migration[7.1]
  def change
    create_table :user_preferences do |t|
      t.integer :age
      t.string :gender
      t.string :activity_level
      t.decimal :weekly_budget_max
      t.integer :max_prep_time_minutes
      t.text :allergies

      t.timestamps
    end
  end
end
