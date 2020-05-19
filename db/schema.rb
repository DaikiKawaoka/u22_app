# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_19_082943) do

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "thing_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "follow_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "things", force: :cascade do |t|
    t.integer "user_id"
    t.string "thing_image"
    t.string "thing_comment"
    t.integer "thing_frequency"
    t.integer "thing_assessment"
    t.integer "thing_type"
    t.string "thing_name"
    t.boolean "thing_shear"
    t.boolean "thing_favorite"
    t.integer "thing_price"
    t.integer "thing_number"
    t.integer "thing_number_remaining"
    t.string "thing_purchase_place"
    t.string "thing_maker"
    t.string "thing_memo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "user_name"
    t.string "email"
    t.string "user_image"
    t.string "user_comment"
    t.integer "sex"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
