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

ActiveRecord::Schema.define(version: 20151008180704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "moments", force: :cascade do |t|
    t.date     "date",       null: false
    t.text     "body",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moments_tags", id: false, force: :cascade do |t|
    t.integer "moment_id", null: false
    t.integer "tag_id",    null: false
  end

  add_index "moments_tags", ["moment_id"], name: "index_moments_tags_on_moment_id", using: :btree
  add_index "moments_tags", ["tag_id"], name: "index_moments_tags_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags_users", id: false, force: :cascade do |t|
    t.integer "tag_id",  null: false
    t.integer "user_id", null: false
  end

  add_index "tags_users", ["tag_id"], name: "index_tags_users_on_tag_id", using: :btree
  add_index "tags_users", ["user_id"], name: "index_tags_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "phone_number",    null: false
    t.string   "locale"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "moments", "users"
end
