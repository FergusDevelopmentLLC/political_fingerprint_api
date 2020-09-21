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

ActiveRecord::Schema.define(version: 2020_09_21_184331) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ideologies", force: :cascade do |t|
    t.string "name"
    t.string "definition"
    t.string "definition_source"
    t.integer "economic_effect"
    t.integer "diplomatic_effect"
    t.integer "government_effect"
    t.integer "societal_effect"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_feedbacks", force: :cascade do |t|
    t.integer "question_iteration_id"
    t.integer "score"
    t.string "explanation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_iterations", force: :cascade do |t|
    t.integer "question_id"
    t.integer "version"
    t.string "content"
    t.integer "economic_effect"
    t.integer "diplomatic_effect"
    t.integer "government_effect"
    t.integer "societal_effect"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "category_id"
    t.integer "current_version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "test_results", force: :cascade do |t|
    t.integer "question_version"
    t.float "economic"
    t.float "diplomatic"
    t.float "civil"
    t.float "societal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "country"
    t.string "country_name"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
  end

end
