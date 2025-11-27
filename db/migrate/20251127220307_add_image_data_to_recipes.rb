class AddImageDataToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :image_data, :text
  end
end
