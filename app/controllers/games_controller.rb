class GamesController < ApplicationController
  include HTTParty

  def index
    @current_page = 'games'
    @games = Game.with_game_code.by_game_code
  end

  def debug
    #raise "debug"
    require 'httparty'


    #url = 'https://ec.nintendo.com/JP/ja/titles/'.freeze
    #json_regex = /NXSTORE\.titleDetail\.jsonData = ([^;]+);/
    #games = []
    #guess_new_ids = ["70010000000027"]
    #guess_new_ids.map do |id|
    #  response = HTTParty.get(URI.join(url, id))
    #  #https://www.nintendo.co.jp/data/software/xml-system/switch-onsale.xml
    #  next unless response.code == 200
    #  games << JSON.parse(response.body.scan(json_regex).last.first, symbolize_names: true)
    #end
    #raise games.inspect


    url_v2 = "https://www.nintendo.co.jp/data/software/xml-system/switch-onsale.xml"
    response = HTTParty.get(URI.join(url_v2))
    raise response.parsed_response["TitleInfoList"]["TitleInfo"].length.inspect
    #raise JSON.parse(response.body).inspect
    #games << JSON.parse(response.body.scan(json_regex).last.first, symbolize_names: true)


    #https://www.nintendo.co.jp/data/software/xml-system/switch-onsale.xml
  end


end

