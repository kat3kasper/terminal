# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_02_202221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.text "message"
    t.integer "status", default: 0
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_applications_on_match_id"
  end

  create_table "benefits", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "industry"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "vetted", default: false
  end

  create_table "companies_cultures", id: false, force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "culture_id", null: false
    t.index ["company_id"], name: "index_companies_cultures_on_company_id"
    t.index ["culture_id"], name: "index_companies_cultures_on_culture_id"
  end

  create_table "competences", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cultures", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "developers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.boolean "need_us_permit", default: false
    t.string "linkedin_url"
    t.string "github_url"
    t.integer "min_salary"
    t.string "city"
    t.string "zip_code"
    t.string "state"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.text "skills_array", default: [], array: true
    t.text "remote", default: [], array: true
    t.integer "mobility", default: 30
    t.boolean "full_mobility"
    t.boolean "first_login", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "subscribed_to_newsletter"
    t.boolean "receives_matches_notifications", default: true
    t.index ["email"], name: "index_developers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_developers_on_reset_password_token", unique: true
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "remote", default: [], array: true
    t.string "city"
    t.string "zip_code"
    t.string "state"
    t.string "country"
    t.boolean "active", default: true
    t.float "latitude"
    t.float "longitude"
    t.integer "max_salary"
    t.text "skills_array", default: [], array: true
    t.string "employment_type"
    t.text "benefits", default: [], array: true
    t.text "cultures", default: [], array: true
    t.boolean "can_sponsor", default: false
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "vetted", default: false
    t.index ["company_id"], name: "index_jobs_on_company_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "developer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["developer_id"], name: "index_matches_on_developer_id"
    t.index ["job_id"], name: "index_matches_on_job_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "stripe_id", null: false
    t.string "name", null: false
    t.decimal "display_price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recruiters", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "main_recruiter", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_recruiters_on_company_id"
    t.index ["email"], name: "index_recruiters_on_email", unique: true
    t.index ["reset_password_token"], name: "index_recruiters_on_reset_password_token", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.string "skillable_type"
    t.bigint "skillable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skillable_type", "skillable_id"], name: "index_skills_on_skillable_type_and_skillable_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "stripe_customer_id", null: false
    t.string "stripe_subscription_id", null: false
    t.datetime "subscribed_at"
    t.datetime "subscription_expires_at"
    t.integer "plan_id", null: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_subscribers_on_company_id"
    t.index ["plan_id"], name: "plans_for_subsribers"
    t.index ["subscribed_at"], name: "subscribed_at_for_subscribers"
    t.index ["subscription_expires_at"], name: "expiring_subscritions_on_subscribers"
  end

  add_foreign_key "applications", "matches"
  add_foreign_key "jobs", "companies"
  add_foreign_key "matches", "developers"
  add_foreign_key "matches", "jobs"
  add_foreign_key "recruiters", "companies"
  add_foreign_key "subscribers", "companies"
end
