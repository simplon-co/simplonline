# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141124143838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer "question_id"
    t.integer "user_id"
    t.integer "chosen_choices", array: true
  end

  create_table "chapter_authors", force: true do |t|
    t.integer "user_id"
    t.integer "chapter_id"
  end

  create_table "chapters", force: true do |t|
    t.integer "lesson_id"
    t.text    "content",             default: "", null: false
    t.string  "title"
    t.string  "tags",                default: [],              array: true
    t.integer "number",              default: 0
    t.boolean "ask_pair_validation"
    t.string  "category"
  end

  create_table "choices", force: true do |t|
    t.string  "content"
    t.integer "question_id"
    t.boolean "valid_answer"
    t.text    "explanation"
  end

  create_table "comments", force: true do |t|
    t.text     "content"
    t.string   "status",     default: "normal"
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "definitions", force: true do |t|
    t.string   "keyword"
    t.text     "description"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "definitions", ["keyword"], name: "index_definitions_on_keyword", using: :btree

  create_table "essais", force: true do |t|
    t.string   "fichier"
    t.boolean  "status"
    t.integer  "exercice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "validateur"
    t.text     "reponse_char"
    t.string   "fichier_tests"
    t.integer  "user_id"
  end

  add_index "essais", ["user_id"], name: "index_essais_on_user_id", using: :btree

  create_table "exercice_authors", force: true do |t|
    t.integer "user_id"
    t.integer "exercice_id"
  end

  create_table "exercices", force: true do |t|
    t.text     "consigne"
    t.text     "echantillon"
    t.text     "reponse"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "format_reponse"
    t.string   "titre"
    t.string   "format_echantillon"
    t.integer  "lesson_id"
    t.integer  "number",             default: 0
  end

  add_index "exercices", ["lesson_id"], name: "index_exercices_on_lesson_id", using: :btree

  create_table "forem_categories", force: true do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "position",   default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true, using: :btree

  create_table "forem_forums", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", default: 0
    t.string  "slug"
    t.integer "position",    default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true, using: :btree

  create_table "forem_groups", force: true do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name", using: :btree

  create_table "forem_memberships", force: true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id", using: :btree

  create_table "forem_moderator_groups", force: true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id", using: :btree

  create_table "forem_posts", force: true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
    t.string   "state",       default: "pending_review"
    t.boolean  "notified",    default: false
  end

  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id", using: :btree
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state", using: :btree
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id", using: :btree
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id", using: :btree

  create_table "forem_subscriptions", force: true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",       default: false,            null: false
    t.boolean  "pinned",       default: false
    t.boolean  "hidden",       default: false
    t.datetime "last_post_at"
    t.string   "state",        default: "pending_review"
    t.integer  "views_count",  default: 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id", using: :btree
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true, using: :btree
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state", using: :btree
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id", using: :btree

  create_table "forem_views", force: true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             default: 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at", using: :btree
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id", using: :btree
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id", using: :btree

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "online",     default: false
  end

  create_table "logs", force: true do |t|
    t.text     "trace"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "status",     default: "normal"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  create_table "qcm_authors", force: true do |t|
    t.integer "user_id"
    t.integer "qcm_id"
  end

  create_table "qcms", force: true do |t|
    t.string   "title"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
    t.integer  "number",     default: 0
  end

  add_index "qcms", ["lesson_id"], name: "index_qcms_on_lesson_id", using: :btree

  create_table "questions", force: true do |t|
    t.string   "title"
    t.integer  "qcm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "tips"
  end

  create_table "submission_results", force: true do |t|
    t.integer  "submission_id"
    t.integer  "user_id"
    t.text     "comment"
    t.boolean  "good",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", force: true do |t|
    t.integer  "chapter_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "first_validation_user_id"
    t.text     "first_validation_comment"
    t.boolean  "first_validation_status",   default: false
    t.integer  "second_validation_user_id"
    t.text     "second_validation_comment"
    t.boolean  "second_validation_status",  default: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                default: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "reset_password_key"
    t.string   "student_type",         default: "remote"
    t.boolean  "forem_admin",          default: false
    t.string   "forem_state",          default: "pending_review"
    t.boolean  "forem_auto_subscribe", default: false
  end

end
