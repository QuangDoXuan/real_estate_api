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

ActiveRecord::Schema.define(version: 2020_11_15_123055) do

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "parent_category_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "web_site"
    t.string "aniverse"
    t.string "field"
    t.string "fund"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.string "slug", limit: 1000
    t.string "thumnail"
  end

  create_table "prefs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", limit: 1000
    t.string "short_code"
    t.text "description"
    t.string "price01"
    t.string "remote_thumbnail", limit: 1000
    t.string "thumnail"
    t.string "address", limit: 1000
    t.integer "bed_rooms"
    t.integer "wc"
    t.string "area"
    t.integer "front_area"
    t.integer "floors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "project_id"
    t.bigint "pref_id"
    t.integer "uid"
    t.datetime "posted_at"
    t.integer "parsed"
    t.string "parse_url", limit: 2000
    t.string "short_description", limit: 1000
    t.float "lon"
    t.float "lat"
    t.integer "is_remote", default: 0
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["pref_id"], name: "index_products_on_pref_id"
    t.index ["project_id"], name: "index_products_on_project_id"
    t.index ["uid"], name: "index_products_on_uid"
  end

  create_table "project_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
  end

  create_table "project_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["project_id"], name: "index_project_images_on_project_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "area"
    t.integer "building_density"
    t.text "place"
    t.text "infras"
    t.string "scale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.string "slug"
    t.string "image"
    t.string "slug_url", limit: 4000
    t.string "pricem2"
    t.string "status"
    t.string "release_at"
    t.string "build_status"
    t.string "price_range"
    t.string "project_category_ids"
    t.bigint "company_id"
    t.string "total_area"
    t.text "description"
    t.float "lon"
    t.string "lat"
    t.string "thumnail"
    t.index ["company_id"], name: "index_projects_on_company_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "product_images", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "prefs"
  add_foreign_key "products", "projects"
  add_foreign_key "project_images", "projects"
  add_foreign_key "projects", "companies"
end
