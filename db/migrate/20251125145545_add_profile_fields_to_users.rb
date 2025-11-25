class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :gender, :string
    add_column :users, :age, :integer
    add_column :users, :physical_activity_profile, :string
  end
end
