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

ActiveRecord::Schema[8.0].define(version: 2025_06_17_031137) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "khmer_calendars", force: :cascade do |t|
    t.integer "year", limit: 2, null: false
    t.string "khmer_calendar_text", limit: 150, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_programs", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "skill_khmer", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name_khmer", limit: 100, null: false
    t.string "name_alphabet", limit: 100, null: false
    t.string "student_school_id", limit: 100
    t.date "birthdate"
    t.string "birth_place", limit: 100
    t.datetime "started_at"
    t.datetime "end_at"
    t.string "photo_path", limit: 300
    t.string "phone_number", limit: 20
    t.string "parent_name", limit: 100
    t.string "parent_phone_number", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "class_name", limit: 50
    t.integer "student_number", null: false
    t.integer "academic_year_start", limit: 2
    t.integer "academic_year_end", limit: 2
    t.string "started_at_khmer_calender", limit: 100
    t.integer "school_program_id", limit: 4
    t.integer "study_level_id", limit: 4
    t.integer "gender", limit: 1, default: 0
    t.index ["name_alphabet"], name: "index_students_on_name_alphabet"
    t.index ["name_khmer"], name: "index_students_on_name_khmer"
    t.index ["student_school_id"], name: "index_students_on_student_school_id", unique: true
  end

  create_table "study_levels", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "name_khmer", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "students", "school_programs"
  add_foreign_key "students", "study_levels"
end
