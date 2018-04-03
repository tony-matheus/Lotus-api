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

ActiveRecord::Schema.define(version: 20180322173024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.string "street"
    t.string "neighborhood"
    t.string "public_place"
    t.string "number"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "complement"
    t.string "cep"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_addresses_on_store_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.string "phone"
    t.string "cellphone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_contacts_on_store_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "images_products", force: :cascade do |t|
    t.bigint "product_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_images_products_on_product_id"
  end

  create_table "images_services", force: :cascade do |t|
    t.bigint "service_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_images_services_on_service_id"
  end

  create_table "images_stores", force: :cascade do |t|
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_images_stores_on_store_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "store_id"
    t.string "name"
    t.integer "amount"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "profile_type", limit: 1, null: false
    t.integer "function"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "store_id"
    t.string "title"
    t.string "name"
    t.string "description"
    t.string "price"
    t.string "time"
    t.integer "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_services_on_store_id"
  end

  create_table "services_products", force: :cascade do |t|
    t.bigint "services_id"
    t.bigint "products_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["products_id"], name: "index_services_products_on_products_id"
    t.index ["services_id"], name: "index_services_products_on_services_id"
  end

  create_table "services_types", force: :cascade do |t|
    t.bigint "services_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["services_id"], name: "index_services_types_on_services_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "CNPJ"
    t.string "category"
    t.string "longitude"
    t.string "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.string "name"
    t.string "cpf"
    t.date "birthday"
    t.string "gender"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "users_stores", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_users_stores_on_store_id"
    t.index ["user_id"], name: "index_users_stores_on_user_id"
  end

  add_foreign_key "addresses", "stores"
  add_foreign_key "addresses", "users"
  add_foreign_key "contacts", "stores"
  add_foreign_key "contacts", "users"
  add_foreign_key "images_products", "products"
  add_foreign_key "images_services", "services"
  add_foreign_key "images_stores", "stores"
  add_foreign_key "products", "stores"
  add_foreign_key "profiles", "users"
  add_foreign_key "services", "stores"
  add_foreign_key "services_products", "products", column: "products_id"
  add_foreign_key "services_products", "services", column: "services_id"
  add_foreign_key "services_types", "services", column: "services_id"
  add_foreign_key "users_stores", "stores"
  add_foreign_key "users_stores", "users"
end
