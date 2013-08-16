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

ActiveRecord::Schema.define(version: 20130816180626) do

  create_table "bookmarks", force: true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "format_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "formats", force: true do |t|
    t.integer  "medium_id"
    t.integer  "format_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phase_associations", force: true do |t|
    t.integer "phase_id"
    t.integer "resource_id"
  end

  create_table "phases", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_responses", force: true do |t|
    t.text     "response"
    t.integer  "trait_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "survey_id"
  end

  create_table "resource_industries", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resource_id"
    t.integer  "industry_id"
  end

  create_table "resources", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "full_description"
    t.integer  "user_id"
    t.string   "source"
  end

  create_table "spectrums", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", force: true do |t|
    t.string   "author"
    t.text     "thoughts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trait_associations", force: true do |t|
    t.integer  "trait_id"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traits", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_trait_description"
    t.integer  "spectrum_id"
    t.string   "image"
  end

  create_table "upvotes", force: true do |t|
    t.integer  "resource_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",        default: false
    t.text     "personality"
  end

end
