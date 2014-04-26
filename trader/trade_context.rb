require 'moving_average'

module Trader

  class TradeContext

    attr_reader :api

    def initialize(api:nil, couple: 'GHS/BTC')
      @couple = couple
      @api = api
      @order_book = nil
      @trade_history = nil
      @balance = nil
      @active_orders = nil
    end

    # returns the current open bids
    def bids
      @order_book['bids'] || []
    end

    # returns the current open asks
    def asks
      @order_book['asks'] || []
    end

    def bid_prices
      bids.map {|bid| bid[0] }
    end

    def ask_prices
      asks.map {|ask| ask[0] }
    end

    def bid_volumes
      bids.map {|bid| bid[1] }
    end

    def ask_volumes
      asks.map {|ask| ask[1] }
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
      @order_book = @api.order_book(@couple)
      @trade_history = @api.trade_history(1,@couple)
      @balance = @api.balance
      @active_orders = @api.open_orders
      return self
    end

    def inspect
      "TradeContext bids:#{bids.size}, asks:#{asks.size}"
    end
  end

end
