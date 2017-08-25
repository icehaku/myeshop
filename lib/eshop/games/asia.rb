require 'httparty'
require_relative '../../eshop'
require_relative '../../eshop/prices'

module Eshop
  class Games
    class Asia
      include HTTParty

      URL = 'https://www.nintendo.co.jp/data/software/xml-system/switch-onsale.xml'.freeze

      def self.list
        response = HTTParty.get(URI.join(URL))
        if response.parsed_response["TitleInfoList"]["TitleInfo"].present?
          games_json = response.parsed_response["TitleInfoList"]["TitleInfo"]

          games = []
          games_json.each do |json|
            games << coerce(json)
          end
        end

        return games
      end

      def self.coerce(game)
        {
          region: 'asia',
          title: game["TitleName"],
          release_date: Date.parse(game["SalesDateStr"]),
          nsuid: parseNID(game["LinkURL"]),
          cover_url: game["ScreenshotImgURL"],
          publisher: game["MakerName"],
          game_code: parseCode(game["ScreenshotImgURL"])[:code],
          raw_game_code: parseCode(game["ScreenshotImgURL"])[:raw],
        }
      end

      def self.parseCode(string)
        if string.present? and string.include?("HAC")
          {raw: string[-12..-5], code: string[-9..-6]}
        else
          {raw: nil, code: nil}
        end
      end

      def self.parseNID(string)
        if string.present?
          string[-14..-1]
        else
          nil
        end
      end
    end
  end
end
