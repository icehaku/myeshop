
require 'httparty'
require_relative '../../eshop'
require_relative '../../eshop/prices'

module Eshop
  class Games
    class AsiaV2
      include HTTParty

      URL = 'https://ec.nintendo.com/JP/ja/titles/'.freeze
      JSON_REGEX = /NXSTORE\.titleDetail\.jsonData = ([^;]+);/

      def self.list
        games = []
        guess_new_ids.map do |id|
          response = get(URI.join(URL, id))
          #https://www.nintendo.co.jp/data/software/xml-system/switch-onsale.xml
          next unless response.code == 200
          games << JSON.parse(response.body.scan(JSON_REGEX).last.first, symbolize_names: true)
        end

        games.compact.map { |g| coerce(g) }
      end

      def self.guess_new_ids
        actual_ids = Game.from_asia.with_nsuid.pluck(:nsuid)
        ids = (FIRST_NSUID..(FIRST_NSUID + 1_500)).map(&:to_s) - actual_ids
        Eshop::Prices.list(country: 'JP', ids: ids).map { |p| p[:nsuid].to_s }
      end

      def self.coerce(game)
        image = ""
        if game[:hero_banner_url].include?("/software/switch/img")
          image = nil
        else
          image = game[:hero_banner_url]
        end

        {
          region: 'asia',
          title: game[:formal_name],
          release_date: Date.parse(game[:release_date_on_eshop]),
          nsuid: game[:id],
          cover_url: parseImg(game[:hero_banner_url]),
        }
      end

      def self.parseImg(image)
        if image.present? and image.include?("/software/switch/img")
          return nil
        else
          return image
        end        
      end

    end
  end
end