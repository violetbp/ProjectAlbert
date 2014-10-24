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

ActiveRecord::Schema.define(version: 20141022153610) do

  create_table "jobs", force: true do |t|
    t.integer  "problem_completion_id"
    t.integer  "problem_id"
    t.string   "file_path"
    t.integer  "points"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problem_completions", force: true do |t|
    t.string   "username"
    t.string   "problemname"
    t.integer  "score"
    t.text     "previousOutput"
    t.integer  "attempt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", force: true do |t|
    t.string   "title"
    t.text     "explanation"
    t.text     "exIn"
    t.text     "exOut"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
