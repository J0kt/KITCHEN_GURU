ActiveRecord::Schema[7.1].define(version: 2025_11_25_151623) do
  enable_extension "plpgsql"

  create_table "meal_plan_recipes", force: :cascade do |t|
    t.bigint "meal_plan_id", null: false
    t.bigint "recipe_id", null: false
    t.string "meal_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan_id"], name: "index_meal_plan_recipes_on_meal_plan_id"
    t.index ["recipe_id"], name: "index_meal_plan_recipes_on_recipe_id"
  end

  create_table "meal_plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "groceries_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "gender"
    t.integer "age"
    t.string "activity_level"
    t.decimal "weekly_budget_max"
    t.integer "max_prep_time_minutes"
    t.text "allergies"
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

  add_foreign_key "meal_plan_recipes", "meal_plans"
  add_foreign_key "meal_plan_recipes", "recipes"
  add_foreign_key "meal_plans", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "recipes", "users"
end
