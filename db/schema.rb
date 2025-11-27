# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_11_27_220307) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
    t.integer "prep_time"
    t.integer "cook_time"
    t.integer "servings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "calories", comment: "Calories par portion (kcal)"
    t.decimal "proteins", precision: 6, scale: 2, comment: "Protéines en grammes"
    t.decimal "carbs", precision: 6, scale: 2, comment: "Glucides en grammes"
    t.decimal "fats", precision: 6, scale: 2, comment: "Lipides en grammes"
    t.decimal "fiber", precision: 6, scale: 2, comment: "Fibres en grammes"
    t.string "difficulty", default: "facile", comment: "Niveau: facile, moyen, difficile"
    t.string "image_url", comment: "URL de l'image de la recette"
    t.decimal "estimated_cost", precision: 6, scale: 2, comment: "Coût estimé en euros"
    t.string "category", comment: "Catégorie: petit-déjeuner, déjeuner, dîner, snack"
    t.string "cuisine_type", comment: "Type de cuisine: française, italienne, etc."
    t.boolean "is_vegetarian", default: false
    t.boolean "is_vegan", default: false
    t.boolean "is_gluten_free", default: false
    t.text "image_data"
    t.index ["category"], name: "index_recipes_on_category"
    t.index ["difficulty"], name: "index_recipes_on_difficulty"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer "age"
    t.string "gender"
    t.string "activity_level"
    t.decimal "weekly_budget_max"
    t.integer "max_prep_time_minutes"
    t.text "allergies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.integer "age"
    t.string "physical_activity_profile"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "recipes", "users"
end
