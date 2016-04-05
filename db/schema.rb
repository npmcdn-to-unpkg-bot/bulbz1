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

ActiveRecord::Schema.define(version: 20160405071939) do

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
    t.string   "big_picture"
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "bulb_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "shops", force: :cascade do |t|
    t.string   "title"
    t.string   "target"
    t.text     "description"
    t.string   "picture"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "profile_picture"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
