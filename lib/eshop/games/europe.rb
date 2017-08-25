require 'httparty'

module Eshop
  class Games
    class Europe
      include HTTParty

      URL = 'http://search.nintendo-europe.com/en/select'.freeze
      DEFAULT_PARAMS = {
        fl: '
          product_code_txt,
          title,
          date_from,
          nsuid_txt,
          image_url_sq_s,
          club_nintendo,
          hd_rumble_b,
          ir_motion_camera_b,
          multiplayer_mode,
          gift_finder_description_s,
          play_mode_tv_mode_b,
          play_mode_handheld_mode_b,
          play_mode_tabletop_mode_b,
          players_from,
          players_to,
          gift_finder_carousel_image_url_s,
          publisher,
          physical_version_b,
          digital_version_b,
          game_categories_txt,
          language_availability,
          ',
        fq: [
          'type:GAME',
          'system_type:nintendoswitch*',
          'product_code_txt:*',
        ].join(' AND '),
        q: '*',
        rows: 9999,
        sort: 'sorting_title asc',
        start: 0,
        wt: 'json',
      }.freeze

      def self.list
        response = get(URL, query: DEFAULT_PARAMS)
        games = JSON.parse(response.body, symbolize_names: true)[:response][:docs]
        games.map { |game| coerce(game) }
      end

      def self.coerce(game)
        lol = {
          region: 'europe',
          game_code: game.dig(:product_code_txt, 0).match(/\AHAC\w?(\w{4})\w\Z/)[1],
          raw_game_code: game.dig(:product_code_txt, 0),
          title: game[:title],
          release_date: Date.parse(game[:date_from]),
          nsuid: game.dig(:nsuid_txt, 0),
          cover_url: game[:image_url_sq_s],

          club_nintendo: game[:club_nintendo],
          hd_rumble_b: game[:hd_rumble_b],
          ir_motion_camera_b: game[:ir_motion_camera_b],
          multiplayer_mode: game[:multiplayer_mode],
          gift_finder_description_s: game[:gift_finder_description_s],
          play_mode_tv_mode_b: game[:play_mode_tv_mode_b],
          play_mode_handheld_mode_b: game[:play_mode_handheld_mode_b],
          play_mode_tabletop_mode_b: game[:play_mode_tabletop_mode_b],
          players_from: game[:players_from],
          players_to: game[:players_to],
          gift_finder_carousel_image_url_s: game[:gift_finder_carousel_image_url_s],
          publisher: game[:publisher],
          physical_version_b: game[:physical_version_b],
          digital_version_b: game[:digital_version_b],
          game_categories_txt: game[:game_categories_txt],
          language_availability: game[:language_availability]
        }
      end
    end
  end
end
