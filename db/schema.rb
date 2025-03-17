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

ActiveRecord::Schema[7.2].define(version: 2025_03_01_175221) do
  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.integer "user_id", null: false
    t.integer "food_transaction_id", null: false
    t.integer "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_feedbacks_on_created_by_id"
    t.index ["food_transaction_id"], name: "index_feedbacks_on_food_transaction_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "food_claims", force: :cascade do |t|
    t.string "claimed_quantity"
    t.string "claim_status"
    t.integer "food_transaction_id", null: false
    t.integer "user_id", null: false
    t.integer "creator_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_user_id"], name: "index_food_claims_on_creator_user_id"
    t.index ["food_transaction_id"], name: "index_food_claims_on_food_transaction_id"
    t.index ["user_id"], name: "index_food_claims_on_user_id"
  end

  create_table "food_transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "food_type"
    t.integer "quantity"
    t.string "description"
    t.text "address"
    t.string "transaction_type"
    t.string "status"
    t.datetime "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_food_transactions_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.string "type"
    t.string "status"
    t.integer "users_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["users_id"], name: "index_notifications_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "role"
    t.text "address"
    t.string "organization_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_approved", default: false
    t.string "password_digest"
  end

  add_foreign_key "feedbacks", "food_transactions"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "feedbacks", "users", column: "created_by_id"
  add_foreign_key "food_claims", "food_transactions"
  add_foreign_key "food_claims", "users"
  add_foreign_key "food_claims", "users", column: "creator_user_id"
  add_foreign_key "food_transactions", "users"
  add_foreign_key "notifications", "users", column: "users_id"
end
