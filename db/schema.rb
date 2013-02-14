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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130214033630) do

  create_table "class_seats", :force => true do |t|
    t.boolean  "drop"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "participants"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "event_type"
    t.string   "note"
    t.string   "ageGroup"
    t.string   "location"
    t.string   "detail"
    t.integer  "user_id"
  end

  create_table "reservations", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "participants"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "seats", :force => true do |t|
    t.boolean  "drop"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "event_id"
  end

  create_table "shifts", :force => true do |t|
    t.boolean  "drop"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "event_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "phone"
    t.string   "fname"
    t.string   "lname"
    t.string   "role"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "street1"
    t.integer  "membership"
    t.string   "note"
    t.string   "detail"
    t.string   "street2"
    t.string   "state"
    t.string   "city"
    t.string   "postcode"
  end

  create_table "xref_user_events", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "host"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "xref_user_reservations", :force => true do |t|
    t.integer  "reservation_id"
    t.integer  "user_id"
    t.boolean  "host"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "drop_shift"
  end

end
