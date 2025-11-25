class AddProfileDetailsToProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :profiles, :gender, :string
    add_column :profiles, :age, :integer
    add_column :profiles, :activity_level, :string
    add_column :profiles, :weekly_budget_max, :decimal
    add_column :profiles, :max_prep_time_minutes, :integer
    add_column :profiles, :allergies, :text
  end
end
