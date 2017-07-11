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

ActiveRecord::Schema.define(version: 20170711022545) do

  create_table "cources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "basic_price", default: 0
    t.integer "special_price", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "geocode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "excel_file_name"
    t.string "excel_content_type"
    t.integer "excel_file_size"
    t.datetime "excel_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spray_sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id", null: false
    t.string "target_month", null: false
    t.integer "equipment_num", null: false
    t.integer "cash_sales_amount", default: 0
    t.integer "prepaid_sales_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_spray_sales_on_place_id"
  end

  create_table "wash_sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id", null: false
    t.date "target_date", null: false
    t.integer "equipment_num", null: false
    t.bigint "cource_id", null: false
    t.integer "sales_count", default: 0
    t.integer "cash_sales_amount", default: 0
    t.integer "prepaid_sales_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cource_id"], name: "index_wash_sales_on_cource_id"
    t.index ["place_id"], name: "index_wash_sales_on_place_id"
  end

  add_foreign_key "spray_sales", "places"
  add_foreign_key "wash_sales", "cources"
  add_foreign_key "wash_sales", "places"
end
