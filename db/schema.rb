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

ActiveRecord::Schema.define(version: 2021_10_21_231908) do

  create_table "comments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_comments_on_job_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "company_profiles", charset: "utf8mb3", force: :cascade do |t|
    t.integer "category_id"
    t.integer "sub_category_id"
    t.text "content"
    t.string "self_introduction"
    t.integer "place_id"
    t.string "company_url"
    t.string "contact"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_company_profiles_on_user_id"
  end

  create_table "contracts", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "contracter_id"
    t.bigint "job_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contracter_id"], name: "index_contracts_on_contracter_id"
    t.index ["job_id"], name: "index_contracts_on_job_id"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "favorites", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_favorites_on_job_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "follows", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["follow_id"], name: "index_follows_on_follow_id"
    t.index ["user_id", "follow_id"], name: "index_follows_on_user_id_and_follow_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "jobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.integer "place_id", null: false
    t.integer "deadline_id", null: false
    t.integer "category_id", null: false
    t.string "job_image"
    t.string "memo"
    t.string "contact"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "requests", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "request_id"
    t.bigint "job_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_requests_on_job_id"
    t.index ["request_id"], name: "index_requests_on_request_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "profile_image"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_photo"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "jobs"
  add_foreign_key "comments", "users"
  add_foreign_key "company_profiles", "users"
  add_foreign_key "contracts", "jobs"
  add_foreign_key "contracts", "users"
  add_foreign_key "contracts", "users", column: "contracter_id"
  add_foreign_key "favorites", "jobs"
  add_foreign_key "favorites", "users"
  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "follow_id"
  add_foreign_key "jobs", "users"
  add_foreign_key "requests", "jobs"
  add_foreign_key "requests", "users"
  add_foreign_key "requests", "users", column: "request_id"
end
