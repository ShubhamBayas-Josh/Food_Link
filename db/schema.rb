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

ActiveRecord::Schema[7.2].define(version: 2025_01_27_192414) do
  create_table "feedbacks", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.integer "users_id", null: false
    t.integer "food_transactions_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_transactions_id"], name: "index_feedbacks_on_food_transactions_id"
    t.index ["users_id"], name: "index_feedbacks_on_users_id"
  end

  create_table "food_claims", force: :cascade do |t|
    t.text "claimed_quantity"
    t.text "claim_status"
    t.integer "food_transactions_id", null: false
    t.integer "users_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_transactions_id"], name: "index_food_claims_on_food_transactions_id"
    t.index ["users_id"], name: "index_food_claims_on_users_id"
  end

  create_table "food_transactions", force: :cascade do |t|
    t.integer "users_id", null: false
    t.string "food_type"
    t.integer "quantity"
    t.string "description"
    t.text "address"
    t.string "transaction_type"
    t.string "status"
    t.date "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_food_transactions_on_users_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.string "type"
    t.string "status"
    t.integer "users_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["users_id"], name: "index_notifications_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "password"
    t.string "role"
    t.text "address"
    t.string "organization_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "feedbacks", "food_transactions", column: "food_transactions_id"
  add_foreign_key "feedbacks", "users", column: "users_id"
  add_foreign_key "food_claims", "food_transactions", column: "food_transactions_id"
  add_foreign_key "food_claims", "users", column: "users_id"
  add_foreign_key "food_transactions", "users", column: "users_id"
  add_foreign_key "notifications", "users", column: "users_id"
end
