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

ActiveRecord::Schema.define(version: 2020_07_29_025419) do

  create_table "categories", force: :cascade do |t|
    t.string "name_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chatrooms", force: :cascade do |t|
    t.integer "course_id"
    t.integer "number_of_words"
    t.integer "gold_bet"
    t.integer "number_members"
    t.string "topic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "slug"
    t.integer "user_id"
    t.index ["user_id"], name: "index_chatrooms_on_user_id"
  end

  create_table "course_words", force: :cascade do |t|
    t.integer "course_id"
    t.integer "word_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_words_on_course_id"
    t.index ["word_id"], name: "index_course_words_on_word_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_name"
    t.integer "category_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.index ["category_id"], name: "index_courses_on_category_id"
  end

# Could not dump table "fts_words" because of following StandardError
#   Unknown type '' for column 'word'

# Could not dump table "fts_words_content" because of following StandardError
#   Unknown type '' for column 'c0word'

  create_table "fts_words_docsize", primary_key: "docid", force: :cascade do |t|
    t.binary "size"
  end

  create_table "fts_words_segdir", primary_key: ["level", "idx"], force: :cascade do |t|
    t.integer "level"
    t.integer "idx"
    t.integer "start_block"
    t.integer "leaves_end_block"
    t.integer "end_block"
    t.binary "root"
  end

  create_table "fts_words_segments", primary_key: "blockid", force: :cascade do |t|
    t.binary "block"
  end

  create_table "fts_words_stat", force: :cascade do |t|
    t.binary "value"
  end

  create_table "join_rooms", force: :cascade do |t|
    t.integer "chatroom_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "ready"
    t.index ["chatroom_id"], name: "index_join_rooms_on_chatroom_id"
    t.index ["user_id"], name: "index_join_rooms_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "chatroom_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "recipient_id"
    t.string "action"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "number_word_learned"
    t.integer "user_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_results_on_course_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "user_learned_words", force: :cascade do |t|
    t.integer "word_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_learned_words_on_user_id"
    t.index ["word_id"], name: "index_user_learned_words_on_word_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "avatar"
    t.integer "gold"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.string "meaning"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "pronounce"
    t.string "word_type"
    t.index ["meaning"], name: "index_words_on_meaning"
    t.index ["word"], name: "index_words_on_word"
  end

  add_foreign_key "chatrooms", "users"
  add_foreign_key "courses", "categories"
  add_foreign_key "join_rooms", "chatrooms"
  add_foreign_key "join_rooms", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "results", "courses"
  add_foreign_key "results", "users"
  add_foreign_key "user_learned_words", "users"
  add_foreign_key "user_learned_words", "words"
end
