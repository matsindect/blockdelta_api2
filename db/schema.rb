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

ActiveRecord::Schema.define(version: 2020_03_11_194947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bloggers", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.string "profession"
    t.string "phone"
    t.bigint "user_id"
    t.bigint "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_pic_file_name"
    t.string "profile_pic_content_type"
    t.integer "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.index ["profile_id"], name: "index_bloggers_on_profile_id"
    t.index ["user_id"], name: "index_bloggers_on_user_id"
  end

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "slug"
    t.boolean "published", default: true, null: false
    t.bigint "user_id"
    t.bigint "sector_id"
    t.bigint "category_id"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "featured_image_file_name"
    t.string "featured_image_content_type"
    t.integer "featured_image_file_size"
    t.datetime "featured_image_updated_at"
    t.index ["category_id"], name: "index_blogs_on_category_id"
    t.index ["sector_id"], name: "index_blogs_on_sector_id"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.string "phone"
    t.bigint "user_id"
    t.bigint "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_pic_file_name"
    t.string "profile_pic_content_type"
    t.integer "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.index ["profile_id"], name: "index_candidates_on_profile_id"
    t.index ["user_id"], name: "index_candidates_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.datetime "event_start_date"
    t.datetime "event_end_date"
    t.string "event_title"
    t.text "event_description"
    t.string "event_venue"
    t.string "website"
    t.bigint "category_id"
    t.bigint "sector_id"
    t.bigint "user_id"
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "featured_image_file_name"
    t.string "featured_image_content_type"
    t.integer "featured_image_file_size"
    t.datetime "featured_image_updated_at"
    t.string "slug"
    t.index ["category_id"], name: "index_events_on_category_id"
    t.index ["sector_id"], name: "index_events_on_sector_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job_title"
    t.string "job_location"
    t.datetime "job_deadline"
    t.string "job_role"
    t.string "job_salary"
    t.string "job_description"
    t.bigint "sector_id"
    t.bigint "category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "slug"
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["sector_id"], name: "index_jobs_on_sector_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.string "role", default: "user", null: false
    t.datetime "last_login"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "jobs", "users"
end
