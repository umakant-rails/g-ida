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

ActiveRecord::Schema.define(version: 20140612124227) do

  create_table "answers", force: true do |t|
    t.string   "answer"
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["poll_id"], name: "index_answers_on_poll_id", using: :btree

  create_table "invitation_polls", force: true do |t|
    t.integer  "invitation_id"
    t.integer  "poll_id"
    t.string   "token"
    t.boolean  "is_enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "polling_allowed_for_all", default: false
    t.integer  "user_id"
  end

  create_table "polls", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "info"
    t.boolean  "has_multiple_answer",     default: false
    t.string   "polling_perids_in_days"
    t.string   "polling_periods_in_days"
    t.datetime "survey_closed_at"
    t.integer  "user_id"
  end

  create_table "responses", force: true do |t|
    t.integer  "answer_id"
    t.string   "userid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poll_id"
  end

  add_index "responses", ["answer_id"], name: "index_responses_on_answer_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.boolean  "mark_as_deleted",        default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
