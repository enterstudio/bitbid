require 'moving_average'
require 'flt'

module Trader

  class TradeContext
    include Flt

    attr_reader :api

    def initialize(api:nil, couple: 'GHS/BTC')
      @couple = couple
      @api = api
      @order_book = nil
      @trade_history = nil
      @balance = nil
      @active_orders = nil
      @first_fetch = false
    end

    # returns the current open bids
    def bids
      @order_book['bids'] || []
    end

    # returns the current open asks
    def asks
      @order_book['asks'] || []
    end

    # returns an array of prices where
    # bid_prices.first is the lowest price
    def bid_prices
      bids.map {|bid| bid[0] }.sort
    end

    # returns an array of prices where
    # ask_prices.first is the lowest price
    def ask_prices
      asks.map {|ask| ask[0] }.sort
    end

    def bid_volumes
      bids.map {|bid| bid[1] }
    end

    def ask_volumes
      asks.map {|ask| ask[1] }
    end

    # calculates the average price over the N cheapest asks
    def min_ask(num=1)
      prices = ask_prices.first(num)
      return prices.reduce(:+)/prices.size
    end

    # calculates the average price over the top N bids
    def max_bid(num=1)
      prices = bid_prices.last(num)
      return prices.reduce(:+)/prices.size
    end

    # Takes the N top bids and N lowest asks, calculates the average price for each one
    # returns the difference
    # @param {number} num the number of highest bids and lowest sells to compare
    def spread(num=1)
      min_ask(num) - max_bid(num)
    end

    # returns the users balance
    def balance
      @balance
    end

    # returns the users current active orders
    def active_orders
      @active_orders
    end

    def trade_history
      @trade_history
    end

    def fetch
      @first_fetch = true
      @order_book = @api.order_book(@couple)
      @trade_history = @api.trade_history(1,@couple)
      @balance = @api.balance
      @active_orders = @api.open_orders

      to_decnum = lambda do |order|
        [ DecNum(order[0].to_s), DecNum(order[1].to_s) ]
      end
      # convert the order book to DecNum
      @order_book['bids'].map!(&to_decnum)
      @order_book['asks'].map!(&to_decnum)


      return self
    end

    def inspect
      if not @first_fetch
        "Trade Context - no nada"
      else
        "bids:#{bids.size}, asks:#{asks.size}, trade hist: #{trade_history.size}, max bid:#{bid_prices.max} , min ask:#{ask_prices.min}"
      end
    end
  end
end
