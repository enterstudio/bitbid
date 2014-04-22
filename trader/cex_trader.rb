require 'cexio'

class CexTrader

  # @param {CEX::API} api an instance of CEX::API properly configured for use
  #                       The instance should be setup for buy, sell, account balance
  #                       and open orders
  def initialize(api)
    @should_terminate = false
    @api = ap
  end

  # calling the start methods starts the trader, i.e. begins trading
  def start
    # TODO
    @should_terminate = false
  end

  def loop
    while @should_terminate == false do
      # first update all the data variables so that there is always a 'fresh' state
      # at least as 'fresh' as possible
      trade_context = update_data()
      if should_buy(trade_context)
        buy_order = calc_buy_order(trade_context)
        place_buy_order(buy_order[0],buy_order[1])
      end
      if should_sell(trade_context)
        sell_order = calc_sell_order(trade_context)
        place_sell_order(sell_order[0],sell_order[1])
      end
    end
  end

  # calls the api to update the trades, bids, asks, balance data
  def update_data

  end

  # this method stops the trader and cancels all active trades
  def terminate
    @should_terminate = true
  end

  # if this method returns true then the trader should buy
  # The trader takes into account a history of trades, te current bids
  # and current asks
  # @param {array} trades an array of trade history where trades[0] is the most recent trade
  # @param {array} bids   an array of current open bids
  # @param {array} asks   an array of current open asks
  def should_buy(trade_context)
    # TODO
  end

  # if this method returns true then the trader should sell
  # The trader takes into account a history of trades, te current bids
  # and current asks
  # @param {array} trades an array of trade history where trades[0] is the most recent trade
  # @param {array} bids   an array of current open bids
  # @param {array} asks   an array of current open asks
  def should_sell(trade_context)
    # TODO
  end

  # Calculates the order that should be placed given the current
  # trader state.
  # @return {array} an array of [price, quantity]
  def calc_buy_order(trade_context)
    #TODO
  end

  # Calculates the order that should be placed given the current
  # trader state.
  # @return {array} an array of [price, quantity]
  def calc_sell_order(trade_context)
    #TODO
  end

  # places a sell order with the given price and amount
  def place_sell_order(price, amount)
    @api.place_order('sell', amount, price, @couple)
  end

  # places a buy order with the given price and amount
  def place_buy_order(price, amount)
    @api.place_order('buy', amount, price, @couple)
  end

end

class Context
end



