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

ActiveRecord::Schema[7.2].define(version: 2025_04_21_083914) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "board_skin_troubles", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.bigint "skin_trouble_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "skin_trouble_id"], name: "index_board_skin_troubles_on_board_id_and_skin_trouble_id", unique: true
    t.index ["board_id"], name: "index_board_skin_troubles_on_board_id"
    t.index ["skin_trouble_id"], name: "index_board_skin_troubles_on_skin_trouble_id"
  end

  create_table "board_skincare_items", force: :cascade do |t|
    t.bigint "board_id"
    t.bigint "skincare_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id", "skincare_item_id"], name: "index_board_skincare_items_on_board_id_and_skincare_item_id", unique: true
    t.index ["board_id"], name: "index_board_skincare_items_on_board_id"
    t.index ["skincare_item_id"], name: "index_board_skincare_items_on_skincare_item_id"
  end

  create_table "boards", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "board_image"
    t.boolean "is_public", default: true, null: false
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

  create_table "skin_troubles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skin_troubles_on_name", unique: true
  end

  create_table "skincare_items", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_skincare_items_on_name", unique: true
  end

  create_table "streaks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "current_streak", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_streaks_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trophies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "trophy_type", null: false
    t.integer "requirement", null: false
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_trophies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "trophy_id", null: false
    t.datetime "achieved_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trophy_id"], name: "index_user_trophies_on_trophy_id"
    t.index ["user_id", "trophy_id"], name: "index_user_trophies_on_user_id_and_trophy_id", unique: true
    t.index ["user_id"], name: "index_user_trophies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "nickname", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "board_skin_troubles", "boards"
  add_foreign_key "board_skin_troubles", "skin_troubles"
  add_foreign_key "board_skincare_items", "boards"
  add_foreign_key "board_skincare_items", "skincare_items"
  add_foreign_key "boards", "users"
  add_foreign_key "cheers", "boards"
  add_foreign_key "cheers", "users"
  add_foreign_key "comments", "boards"
  add_foreign_key "comments", "users"
  add_foreign_key "user_trophies", "trophies"
  add_foreign_key "user_trophies", "users"
end
