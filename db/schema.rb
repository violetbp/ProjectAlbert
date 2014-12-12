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

ActiveRecord::Schema.define(version: 20141212212110) do

  create_table "groups", force: true do |t|
    t.string   "title"
    t.text     "explanation"
    t.string   "teacher"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_problemsets", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "problemset_id"
  end

  create_table "groups_users", id: false, force: true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "jobs", force: true do |t|
    t.integer  "problem_id"
    t.string   "file_path"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "previous_output"
    t.integer  "attempt"
    t.integer  "user_id",         default: 0
    t.integer  "points",          default: 1
    t.integer  "style",           default: 0
    t.integer  "function",        default: 0
    t.integer  "solution",        default: 0
    t.boolean  "submitted",       default: false
  end

  create_table "problems", force: true do |t|
    t.string   "title"
    t.text     "explanation"
    t.text     "exIn"
    t.text     "exOut"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
    t.string   "active_probs", default: ""
    t.string   "extra_probs",  default: ""
    t.string   "grading_type", default: ""
  end

  create_table "problems_problemsets", id: false, force: true do |t|
    t.integer "problem_id"
    t.integer "problemset_id"
  end

  create_table "problemsets", force: true do |t|
    t.string   "title"
    t.text     "explanation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "due_date"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
    t.string   "image"
    t.text     "about"
    t.integer  "grade"
  end

end
