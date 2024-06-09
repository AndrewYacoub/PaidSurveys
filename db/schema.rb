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

ActiveRecord::Schema.define(version: 2024_06_09_141059) do

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "account_number"
    t.string "bank_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bank_accounts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "choices", force: :cascade do |t|
    t.integer "question_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "content"
    t.boolean "read"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "opinions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "survey_id", null: false
    t.text "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_opinions_on_survey_id"
    t.index ["user_id"], name: "index_opinions_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "target_group"
    t.string "about_publisher"
    t.decimal "price"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.string "occupation"
    t.string "education"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "survey_id", null: false
    t.string "question_type"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "responses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "survey_id", null: false
    t.integer "choice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "question_id", null: false
    t.index ["choice_id"], name: "index_responses_on_choice_id"
    t.index ["question_id"], name: "index_responses_on_question_id"
    t.index ["survey_id"], name: "index_responses_on_survey_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.string "title"
    t.text "description"
    t.decimal "reward"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id", null: false
    t.index ["category_id"], name: "index_surveys_on_category_id"
    t.index ["product_id"], name: "index_surveys_on_product_id"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "survey_id", null: false
    t.decimal "amount"
    t.string "payment_method"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_transactions_on_survey_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.boolean "admin"
    t.integer "age"
    t.string "gender"
    t.string "occupation"
    t.string "education"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider"
    t.string "wallet_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "balance"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "bank_accounts", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "notifications", "users"
  add_foreign_key "opinions", "surveys"
  add_foreign_key "opinions", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "surveys"
  add_foreign_key "responses", "choices"
  add_foreign_key "responses", "questions"
  add_foreign_key "responses", "surveys"
  add_foreign_key "responses", "users"
  add_foreign_key "surveys", "categories"
  add_foreign_key "surveys", "products"
  add_foreign_key "surveys", "users"
  add_foreign_key "transactions", "surveys"
  add_foreign_key "transactions", "users"
  add_foreign_key "wallets", "users"
end
