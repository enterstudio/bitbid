require "weary"
require "json"

class CoinbaseAPI < Weary::Client
  domain "https://coinbase.com/api/v1"

  use Rack::Lint

  # returns the current price and information as a JSON object
  # The JSON object contains the following keys:
  # subtotal:
  #
  # fees:
  #   fee information
  # total:
  #   amount: the price of 1 BTC in USD
  #   currency: USD
  get :buy_price, "/prices/buy"

  get :sell_price, "/prices/sell"

end

# A simple ruby wrapper for the Coinbase API
class Coinbase

  def initialize
    @api = CoinbaseAPI.new
  end

  # dynamically create the buy_price and sell_price methods
  %W(buy_price sell_price).each do |method|
    define_method(method) do
      body = @api.send(method).perform.body
      JSON(body)
    end
  end

  # returns the current buying price of 1 BTC in Coinbase
  def total_buy_price
    buy_price["total"]["amount"].to_f
  end

  # returns the current selling price of 1 BTC in Coinbase
  def total_sell_price
    sell_price["total"]["amount"].to_f
  end

end
