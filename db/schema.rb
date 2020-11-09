# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_09_085725) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "delete_flag", default: 0, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "created_at"], name: "index_categories_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.integer "month"
    t.integer "spending_category", default: 0, null: false
    t.integer "type_money", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.float "moneys"
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_plans_on_category_id"
    t.index ["user_id", "month"], name: "index_plans_on_user_id_and_month"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "shares", force: :cascade do |t|
    t.integer "month"
    t.integer "from_user_id", null: false
    t.integer "to_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["from_user_id"], name: "index_shares_on_from_user_id"
    t.index ["to_user_id"], name: "index_shares_on_to_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.integer "role", default: 1, null: false
    t.integer "delete_flag", default: 0, null: false
    t.string "reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "provider"
    t.string "uid"
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "plans", "categories"
  add_foreign_key "plans", "users"
  add_foreign_key "shares", "users", column: "from_user_id"
  add_foreign_key "shares", "users", column: "to_user_id"
end
