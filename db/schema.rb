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

ActiveRecord::Schema[8.1].define(version: 2026_08_13_125600) do
  create_table "activities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lesson_id", null: false
    t.string "name"
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_activities_on_lesson_id"
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.integer "language_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_courses_on_language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "language_id", null: false
    t.string "name"
    t.integer "section_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
    t.index ["language_id"], name: "index_lessons_on_language_id"
    t.index ["section_id"], name: "index_lessons_on_section_id"
  end

  create_table "level_courses", force: :cascade do |t|
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.integer "level_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_level_courses_on_course_id"
    t.index ["level_id"], name: "index_level_courses_on_level_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "order"
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "level_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_sections_on_level_id"
  end

  create_table "user_languages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "language_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["language_id"], name: "index_user_languages_on_language_id"
    t.index ["user_id"], name: "index_user_languages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "current_language_id", null: false
    t.string "email"
    t.string "nome"
    t.string "password"
    t.datetime "updated_at", null: false
    t.index ["current_language_id"], name: "index_users_on_current_language_id"
  end

  add_foreign_key "activities", "lessons"
  add_foreign_key "courses", "languages"
  add_foreign_key "lessons", "courses"
  add_foreign_key "lessons", "languages"
  add_foreign_key "lessons", "sections"
  add_foreign_key "level_courses", "courses"
  add_foreign_key "level_courses", "levels"
  add_foreign_key "sections", "levels"
  add_foreign_key "user_languages", "languages"
  add_foreign_key "user_languages", "users"
  add_foreign_key "users", "current_languages"
end
