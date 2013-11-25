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

ActiveRecord::Schema.define(version: 20131103071212) do

  create_table "admin", force: true do |t|
    t.string "adminname",     limit: 45
    t.string "adminpassword", limit: 45
    t.string "level",         limit: 45
    t.string "description",   limit: 1000
  end

  create_table "event", force: true do |t|
    t.integer  "userid"
    t.datetime "starttime"
    t.datetime "endtime"
    t.string   "repeat",     limit: 50
    t.string   "eventname",  limit: 500
    t.string   "decription", limit: 1000
    t.string   "place",      limit: 500
    t.integer  "weekday"
  end

  add_index "event", ["userid"], name: "event_userid_idx", using: :btree

  create_table "group_events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groupevent", force: true do |t|
    t.integer "groupid"
    t.integer "eventid"
    t.string  "description", limit: 1000
  end

  add_index "groupevent", ["eventid"], name: "groupevent_eventid_idx", using: :btree
  add_index "groupevent", ["groupid"], name: "groupevent_groupid_idx", using: :btree

  create_table "groupmember", force: true do |t|
    t.integer  "userid"
    t.integer  "groupid"
    t.datetime "time"
    t.string   "description", limit: 1000
  end

  add_index "groupmember", ["groupid"], name: "groupmember_groupid_idx", using: :btree
  add_index "groupmember", ["userid"], name: "groupmember_userid_idx", using: :btree

  create_table "groups", force: true do |t|
    t.string  "name",        limit: 100
    t.string  "categroy",    limit: 100
    t.string  "description", limit: 1000
    t.integer "userid"
    t.integer "size",                     default: 0
    t.integer "adminid"
    t.string  "image",       limit: 1000
  end

  add_index "groups", ["adminid"], name: "fk_groups_2_idx", using: :btree
  add_index "groups", ["userid"], name: "fk_groups_1_idx", using: :btree

  create_table "log", force: true do |t|
    t.datetime "time"
    t.string   "ip",     limit: 25
    t.string   "detail", limit: 1000
    t.integer  "userid"
  end

  add_index "log", ["userid"], name: "userid_idx", using: :btree

  create_table "login", force: true do |t|
    t.string  "username", limit: 50
    t.string  "password", limit: 20
    t.integer "userid"
  end

  add_index "login", ["userid"], name: "userid_idx", using: :btree

  create_table "privateevent", force: true do |t|
    t.integer "userid"
    t.integer "eventid"
    t.string  "description", limit: 1000
  end

  add_index "privateevent", ["eventid"], name: "privateevent_eventid_idx", using: :btree
  add_index "privateevent", ["userid"], name: "privateevent_userid_idx", using: :btree

  create_table "user", force: true do |t|
    t.string "sex",          limit: 15
    t.string "email",        limit: 100
    t.string "picture",      limit: 100
    t.string "firstname",    limit: 50
    t.string "lastname",     limit: 50
    t.string "occupation",   limit: 50
    t.string "skills",       limit: 500
    t.date   "birthday"
    t.string "relationship", limit: 50
    t.string "orientation",  limit: 50
    t.string "introduction", limit: 5000
  end

end
