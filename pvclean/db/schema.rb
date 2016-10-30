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

ActiveRecord::Schema.define(version: 20161030161207) do

  create_table "robot_infos", force: :cascade do |t|
    t.float    "battery"
    t.float    "temperature"
    t.float    "humidity"
    t.float    "water"
    t.string   "position"
    t.integer  "robot_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "robot_infos", ["robot_id"], name: "index_robot_infos_on_robot_id"

  create_table "robots", force: :cascade do |t|
    t.integer  "status"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "robots_routines", force: :cascade do |t|
    t.integer "robot_id"
    t.integer "routine_id"
  end

  add_index "robots_routines", ["robot_id"], name: "index_robots_routines_on_robot_id"
  add_index "robots_routines", ["routine_id"], name: "index_robots_routines_on_routine_id"

  create_table "routine_results", force: :cascade do |t|
    t.datetime "date"
    t.string   "result"
    t.integer  "routine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "routine_results", ["routine_id"], name: "index_routine_results_on_routine_id"

  create_table "routines", force: :cascade do |t|
    t.time     "time"
    t.integer  "week_day"
    t.boolean  "enable"
    t.boolean  "monthly"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "task_id"
  end

  add_index "routines", ["task_id"], name: "index_routines_on_task_id"

  create_table "tasks", force: :cascade do |t|
    t.integer  "code"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
