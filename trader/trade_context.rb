
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
      @order_book['bids']
    end

    # returns the current open asks
    def asks
      @order_book['asks']
    end

    # returns the users balance
    def balance
      @balance
    end

    # returns the users current active orders
    def active_orders
      @active_orders
    end

    def fetch
      @order_book = @api.order_book(@couple)
      @trade_history = @api.trade_history(1,@couple)
      @balance = @api.balance
      @active_orders = @api.open_orders
      return self
    end
  end

end
