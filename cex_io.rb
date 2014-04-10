require "weary"
require "json"

class CexAPI < Weary::Client
  domain "https://cex.io/api"

  use Rack::Lint

  # Returns JSON dictionary:
  #   last - last BTC price
  #   high - last 24 hours price high
  #   low - last 24 hours price low
  #   volume - last 24 hours volume
  #   bid - highest buy order
  #   ask - lowest sell order
  get :ticker, "/ticker/GHS/BTC"

  # Returns JSON dictionary with "bids" and "asks".
  # Each is a list of open orders and each order is represented as a list of price and amount.
  # Response form:
  # bids: [[price, amount],[price, amount],...]
  # asks: [[price, amount],[price, amount],...]
  get :order_book, "/order_book/GHS/BTC"

  # Returns a list of recent trades, where each trade is a JSON dictionary:
  #   tid - trade id
  #   amount - trade amount
  #   price - price
  #   date - UNIX timestamp
  get :trade_history, "/trade_history/GHS/BTC"
end

class CexIO

  def initialize()
    @api = CexAPI.new
  end

  %W(ticker order_book trade_history).each do |method|
    define_method(method) do
      body = @api.send(method).perform.body
      JSON(body)
    end
  end

end
