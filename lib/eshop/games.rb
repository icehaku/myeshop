require 'httparty'
require_relative 'games/asia'
require_relative 'games/asia_v2'
require_relative 'games/americas'
require_relative 'games/europe'

module Eshop
  class Games
    def self.list
      Americas.list + Europe.list + AsiaV2.list + Asia.list 
    end
  end
end
