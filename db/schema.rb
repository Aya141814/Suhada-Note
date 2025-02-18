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

ActiveRecord::Schema[7.2].define(version: 2025_02_11_090348) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "board_image"
    t.string "category_name", default: "スキンケア", null: false
    t.index ["user_id", "category_name"], name: "index_boards_on_user_id_and_category_name"
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "cheers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_cheers_on_board_id"
    t.index ["user_id", "board_id"], name: "index_cheers_on_user_id_and_board_id", unique: true
    t.index ["user_id"], name: "index_cheers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "board_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_comments_on_board_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "streaks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "current_streak", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category_name", default: "スキンケア", null: false
    t.index ["user_id", "category_name"], name: "index_streaks_on_user_id_and_category_name", unique: true
    t.index ["user_id"], name: "index_streaks_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "boards", "users"
  add_foreign_key "cheers", "boards"
  add_foreign_key "cheers", "users"
  add_foreign_key "comments", "boards"
  add_foreign_key "comments", "users"
end
