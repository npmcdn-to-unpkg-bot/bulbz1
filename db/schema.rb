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

ActiveRecord::Schema.define(version: 20160328095118) do

  create_table "apps", force: :cascade do |t|
    t.string   "title"
    t.string   "target"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bulbs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "what"
    t.text     "forwhom"
    t.text     "why"
    t.text     "need"
    t.string   "category"
    t.boolean  "private",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "target"
    t.string   "verb"
    t.text     "description"
    t.string   "art"
    t.string   "picture"
    t.string   "target2"
    t.string   "cat"
    t.integer  "ref_id"
    t.string   "target1"
  end

  create_table "platforms", force: :cascade do |t|
    t.string   "title"
    t.string   "target1"
    t.string   "target2"
    t.text     "description"
    t.text     "gain1"
    t.text     "gain2"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "title"
    t.string   "target"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
