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

ActiveRecord::Schema.define(version: 20170822080137) do

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "basic_price", default: 0
    t.integer "special_price", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mail_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "mail_info_id", null: false
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mail_info_id"], name: "index_mail_files_on_mail_info_id"
  end

  create_table "mail_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.string "from"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "received_at"
  end

  create_table "place_aliases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_place_aliases_on_name", unique: true
    t.index ["place_id"], name: "index_place_aliases_on_place_id"
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "geocode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "equipment_count"
  end

  create_table "sales_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "excel_file_name"
    t.string "excel_content_type"
    t.integer "excel_file_size"
    t.datetime "excel_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales_summaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id", null: false
    t.string "target_month", null: false
    t.integer "sales_count", default: 0
    t.integer "sales_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_sales_summaries_on_place_id"
  end

  create_table "spray_sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id", null: false
    t.string "target_month", null: false
    t.integer "equipment_num", null: false
    t.integer "cash_sales_amount", default: 0
    t.integer "prepaid_sales_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sales_count"
    t.index ["place_id"], name: "index_spray_sales_on_place_id"
  end

  create_table "wash_sale_courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "wash_sale_id", null: false
    t.bigint "course_id"
    t.integer "sales_count"
    t.integer "cash_sales_amount"
    t.integer "prepaid_sales_amount"
    t.index ["course_id"], name: "index_wash_sale_courses_on_course_id"
    t.index ["wash_sale_id"], name: "index_wash_sale_courses_on_wash_sale_id"
  end

  create_table "wash_sales", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "place_id", null: false
    t.date "target_date", null: false
    t.integer "equipment_num", null: false
    t.integer "sales_count", default: 0
    t.integer "cash_sales_amount", default: 0
    t.integer "prepaid_sales_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "prepaid_sales_point"
    t.index ["place_id"], name: "index_wash_sales_on_place_id"
  end

  add_foreign_key "mail_files", "mail_infos"
  add_foreign_key "place_aliases", "places"
  add_foreign_key "sales_summaries", "places"
  add_foreign_key "spray_sales", "places"
  add_foreign_key "wash_sale_courses", "courses"
  add_foreign_key "wash_sale_courses", "wash_sales"
  add_foreign_key "wash_sales", "places"
end
