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

ActiveRecord::Schema.define(version: 20170825001807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_rates", force: :cascade do |t|
    t.string "from", limit: 3
    t.string "to", limit: 3
    t.float "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "raw_game_code"
    t.string "game_code"
    t.string "nsuid"
    t.string "region"
    t.string "title"
    t.datetime "release_date"
    t.string "cover_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "club_nintendo"
    t.boolean "hd_rumble_b"
    t.boolean "ir_motion_camera_b"
    t.boolean "multiplayer_mode"
    t.string "gift_finder_description_s"
    t.boolean "play_mode_tv_mode_b"
    t.boolean "play_mode_handheld_mode_b"
    t.boolean "play_mode_tabletop_mode_b"
    t.string "players_from"
    t.string "players_to"
    t.string "gift_finder_carousel_image_url_s"
    t.string "publisher"
    t.boolean "physical_version_b"
    t.boolean "digital_version_b"
    t.string "game_categories_txt"
    t.string "language_availability"
    t.index ["game_code"], name: "index_games_on_game_code"
    t.index ["nsuid"], name: "index_games_on_nsuid"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "game_id"
    t.string "nsuid"
    t.string "country", limit: 2
    t.string "status"
    t.string "currency", limit: 3
    t.integer "value_in_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "discount_value_in_cents"
    t.datetime "discount_datetime_start"
    t.datetime "discount_datetime_end"
    t.index ["game_id"], name: "index_prices_on_game_id"
    t.index ["nsuid", "country"], name: "index_prices_on_nsuid_and_country", unique: true
  end

  add_foreign_key "prices", "games"
end
