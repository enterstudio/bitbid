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

ActiveRecord::Schema.define(version: 20140417025124) do

  create_table "asks", force: true do |t|
    t.float    "price"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bids", force: true do |t|
    t.float    "price"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cexio_tickers", force: true do |t|
    t.float    "last"
    t.float    "high"
    t.float    "low"
    t.float    "volume"
    t.float    "bid"
    t.float    "ask"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coinbase_prices", force: true do |t|
    t.float    "buy_price"
    t.float    "sell_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trades", force: true do |t|
    t.string   "tid"
    t.float    "amount"
    t.float    "price"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
