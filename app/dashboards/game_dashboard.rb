require "administrate/base_dashboard"

class GameDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    prices: Field::HasMany,
    id: Field::Number,
    raw_game_code: Field::String,
    game_code: Field::String,
    nsuid: Field::String,
    region: Field::String,
    title: Field::String,
    release_date: Field::DateTime,
    cover_url: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    club_nintendo: Field::Boolean,
    hd_rumble_b: Field::Boolean,
    ir_motion_camera_b: Field::Boolean,
    multiplayer_mode: Field::Boolean,
    gift_finder_description_s: Field::String,
    play_mode_tv_mode_b: Field::Boolean,
    play_mode_handheld_mode_b: Field::Boolean,
    play_mode_tabletop_mode_b: Field::Boolean,
    players_from: Field::String,
    players_to: Field::String,
    gift_finder_carousel_image_url_s: Field::String,
    publisher: Field::String,
    physical_version_b: Field::Boolean,
    digital_version_b: Field::Boolean,
    game_categories_txt: Field::String,
    language_availability: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :prices,
    :id,
    :raw_game_code,
    :game_code,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :prices,
    :id,
    :raw_game_code,
    :game_code,
    :nsuid,
    :region,
    :title,
    :release_date,
    :cover_url,
    :created_at,
    :updated_at,
    :club_nintendo,
    :hd_rumble_b,
    :ir_motion_camera_b,
    :multiplayer_mode,
    :gift_finder_description_s,
    :play_mode_tv_mode_b,
    :play_mode_handheld_mode_b,
    :play_mode_tabletop_mode_b,
    :players_from,
    :players_to,
    :gift_finder_carousel_image_url_s,
    :publisher,
    :physical_version_b,
    :digital_version_b,
    :game_categories_txt,
    :language_availability,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :prices,
    :raw_game_code,
    :game_code,
    :nsuid,
    :region,
    :title,
    :release_date,
    :cover_url,
    :club_nintendo,
    :hd_rumble_b,
    :ir_motion_camera_b,
    :multiplayer_mode,
    :gift_finder_description_s,
    :play_mode_tv_mode_b,
    :play_mode_handheld_mode_b,
    :play_mode_tabletop_mode_b,
    :players_from,
    :players_to,
    :gift_finder_carousel_image_url_s,
    :publisher,
    :physical_version_b,
    :digital_version_b,
    :game_categories_txt,
    :language_availability,
  ].freeze

  # Overwrite this method to customize how games are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(game)
  #   "Game ##{game.id}"
  # end
end
