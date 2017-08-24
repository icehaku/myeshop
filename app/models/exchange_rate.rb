class ExchangeRate < ActiveRecord::Base
  def self.get_rate(from_iso_code, to_iso_code)
    rate = find_by(:from => from_iso_code, :to => to_iso_code)
    rate.present? ? rate.rate : nil
  end

  def self.add_rate(from_iso_code, to_iso_code, rate)
    exrate = find_or_initialize_by(:from => from_iso_code, :to => to_iso_code)
    exrate.rate = rate
    exrate.save!
  end

  def self.key(a, b)
    "#{a}_TO_#{b}"
  end
end


#VIA REDIS
#class ExchangeRate
#  def initialize(opts)
#    @client = Redis.new(opts)
#  end
#
#  def add_rate(iso_from, iso_to, rate)
#    @client.set key(iso_from, iso_to), rate
#  end
#
#  def get_rate(iso_from, iso_to)
#    @client.get key(iso_from, iso_to)
#  end
#
#  private
#
#  def key(a, b)
#    "#{a}_TO_#{b}"
#  end
#end
