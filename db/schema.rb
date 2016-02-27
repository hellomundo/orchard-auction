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

ActiveRecord::Schema.define(version: 20160226224825) do

  create_table "buyers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
    t.string   "telephone"
    t.integer  "guests"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "donor_id"
    t.text     "note"
    t.integer  "channel"
    t.date     "contacted_on"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  add_index "contacts", ["donor_id"], name: "index_contacts_on_donor_id"
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "donors", force: :cascade do |t|
    t.string   "company"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "status",      default: 0
    t.string   "email"
    t.string   "phone"
    t.boolean  "has_donated"
    t.string   "website"
    t.string   "title"
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "fmv",           precision: 8, scale: 2
    t.integer  "donor_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "lot_id"
    t.text     "restrictions"
    t.integer  "format",                                default: 0
    t.float    "opening_price"
    t.integer  "category",                              default: 0
  end

  add_index "items", ["donor_id"], name: "index_items_on_donor_id"
  add_index "items", ["lot_id"], name: "index_items_on_lot_id"

  create_table "lots", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "opening_price"
    t.float    "bid_increment"
    t.float    "buy_now_price"
    t.integer  "table_number"
    t.integer  "quantity_available"
  end

  create_table "pledges", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "buyer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "pledge_type"
  end

  add_index "pledges", ["buyer_id"], name: "index_pledges_on_buyer_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "wins", force: :cascade do |t|
    t.integer  "buyer_id"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "lot_id"
  end

  add_index "wins", ["buyer_id"], name: "index_wins_on_buyer_id"
  add_index "wins", ["lot_id"], name: "index_wins_on_lot_id"

end
