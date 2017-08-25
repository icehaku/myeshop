class AddMoreGamesFields < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :club_nintendo, :boolean
    add_column :games, :hd_rumble_b, :boolean
    add_column :games, :ir_motion_camera_b, :boolean
    add_column :games, :multiplayer_mode, :boolean
    add_column :games, :gift_finder_description_s, :string
    add_column :games, :play_mode_tv_mode_b, :boolean
    add_column :games, :play_mode_handheld_mode_b, :boolean
    add_column :games, :play_mode_tabletop_mode_b, :boolean
    add_column :games, :players_from, :string
    add_column :games, :players_to, :string
    add_column :games, :gift_finder_carousel_image_url_s, :string
    add_column :games, :publisher, :string
    add_column :games, :physical_version_b, :boolean
    add_column :games, :digital_version_b, :boolean
    add_column :games, :game_categories_txt, :string
    add_column :games, :language_availability, :string
  end
end
