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
          cover_url: parseImg(game["ScreenshotImgURL"]),
          publisher: game["MakerName"],
          game_code: parseCode(game["ScreenshotImgURL"], game["LinkURL"])[:code],
          raw_game_code: parseCode(game["ScreenshotImgURL"], game["LinkURL"])[:raw],
        }
      end

      def self.parseCode(scr_url, link_url)
        if scr_url.present? and scr_url.include?("HAC")
          {raw: scr_url[-12..-5], code: scr_url[-9..-6]}
        elsif link_url.present? and link_url.include?("index.")
          {raw: "HAC"+link_url[-16..-12].upcase, code: link_url[-16..-13].upcase}
        else
          {raw: nil, code: nil}
        end
      end

      def self.parseNID(string)
        if string..present? and !string.include?("index.")
          string[-14..-1]
        else
          nil
        end
      end

      def self.parseImg(image)
        if image.present? and image.include?("/software/switch/img")
          return "https://www.nintendo.co.jp/"+image
        elsif image.present? and image.include?("//cdn")
          return "https:"+image
        else
          return image
        end        
      end

    end
  end
end
