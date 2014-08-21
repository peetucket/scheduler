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

ActiveRecord::Schema.define(version: 20140821040220) do

  create_table "assets", force: true do |t|
    t.string   "kind",                     null: false
    t.integer  "client_id",                null: false
    t.integer  "availability", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", force: true do |t|
    t.integer  "asset_id",    null: false
    t.integer  "timeslot_id", null: false
    t.integer  "tickets",     null: false
    t.string   "ticket_type", null: false
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "name",                      null: false
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeslots", force: true do |t|
    t.string   "name",                   null: false
    t.date     "date"
    t.time     "start_time"
    t.integer  "duration",   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeslots", ["name"], name: "index_timeslots_on_name"

end
