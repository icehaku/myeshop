MoneyRails.configure do |config|
  #VIA REDIS
  #REDIS_URL = ENV.fetch('REDIS_URL') { 'redis://localhost:6379' }
  #config.default_bank = Money::Bank::VariableExchange.new(ExchangeRate.new(url: REDIS_URL))
  Money.default_bank = Money::Bank::VariableExchange.new(ExchangeRate)
end
