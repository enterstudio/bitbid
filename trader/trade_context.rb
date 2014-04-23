
module Trader

  class TradeContext



    def initialize(api)
      @api = api
      @order_book = nil
      @trade_history = nil
      @balance = nil
      @current_orders
    end

    # returns the current open bids
    def bids
      #TODO
    end

    # returns the current open asks
    def asks
      #TODO
    end

    # returns the users balance
    def balance
      # TODO
    end

    # returns the users current active orders
    def active_orders
      # TODO
    end

    def fetch
      return self
    end
  end

end
