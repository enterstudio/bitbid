require 'cexio'
require 'logger'

module Trader
  class CexTrader

    attr_reader :should_terminate
    attr_reader :trade_context

    # @param {CEX::API} api an instance of CEX::API properly configured for use
    #                       The instance should be setup for buy, sell, account balance
    #                       and open orders
    def initialize(log: nil, sleep_period: 30, trade_context: nil, api: nil)
      @should_terminate = false
      @sleep_period = sleep_period
      @trade_context = trade_context
      @log = log
      @api = api
    end

    # calling the start methods starts the trader, i.e. begins trading
    def start
      @log.info "starting trader"
      @should_terminate = false
      iterate()
    end

    # iterates while @should_terminate is false
    #
    # The CexTrader takes several steps in the following order
    # 1. Fetches al data from the API through the TradeContext class.
    # 2. Checks if any open orders should be canceled
    # 3. Calculates if a buy should be made
    #   => places the buy
    # 4. Calculates if a sell should be made
    #   => places the sell
    # 5. sleeps and re-iterates
    def iterate(run_once: false)
      while @should_terminate == false do
        begin
          @log.debug "iterating"
          # first update all the data variables so that there is always a 'fresh' state
          # at least as 'fresh' as possible
          trade_context = get_trade_context()
          @log.debug "Trade context obtained"
          @log.debug(trade_context)

          on_data_loaded(trade_context)

          # checks if orders should be canceled and tells the API to cancel them
          if should_cancel(trade_context)
            @log.info "shoul cancel is true"
            order_ids = get_orders_to_cancel(trade_context)
            @log.info "will cancel #{order_ids}"
            cancel_orders(order_ids)
          end
          # given a trade_context, our task now is to figure out if a buy should be placed
          if should_buy(trade_context)
            @log.info "should_buy is true"
            buy_order = calc_buy_order(trade_context)
            place_buy_order(buy_order[0],buy_order[1])
          end
          # now, lets figure out if a sell should be made (first buy then sell)
          if should_sell(trade_context)
            @log.info "should sell is true"
            sell_order = calc_sell_order(trade_context)
            place_sell_order(sell_order[0],sell_order[1])
          end

          break if run_once
          sleep(@sleep_period)
        rescue => err
          @log.error("Error while iterating")
          @log.error(err)
          break
        end
      end
    end

    # Cancels all orders with the given ids
    def cancel_orders(order_ids)
      order_ids.each do |id|
        @api.cancel_order(id)
        @log.info "successfully cancelled order #{id}"
      end
    end

    # calls the api to update the trades, bids, asks, balance data
    def get_trade_context
      return @trade_context.fetch
    end

    # this method stops the trader and cancels all active trades
    # TODO not sure if this method is useful right now, maybe in the near future it will be removed
    def terminate
      @should_terminate = true
    end

    # places a sell order with the given price and amount
    def place_sell_order(price, amount)
      @log.info "placing sell order for price: #{price}, amount: #{amount}"
      @api.place_order('sell', amount, price, @couple)
    end

    # places a buy order with the given price and amount
    def place_buy_order(price, amount)
      @log.info "placing buy order for price: #{price}, amount: #{amount}"
      @api.place_order('buy', amount, price, @couple)
    end

    # optional method to be implemented in case the user needs to do some logging as soon as the data is received
    def on_data_loaded(trade_context)
      # do nothing
    end

    # if this method returns true then the trader should buy
    # The trader takes into account a history of trades, te current bids
    # and current asks
    # @param {array} trades an array of trade history where trades[0] is the most recent trade
    # @param {array} bids   an array of current open bids
    # @param {array} asks   an array of current open asks
    def should_buy(trade_context)
      raise NotImplementedError, 'unimplemented method should_buy'
    end

    # if this method returns true then the trader should sell
    # The trader takes into account a history of trades, te current bids
    # and current asks
    # @param {array} trades an array of trade history where trades[0] is the most recent trade
    # @param {array} bids   an array of current open bids
    # @param {array} asks   an array of current open asks
    def should_sell(trade_context)
      raise NotImplementedError, 'unimplemented method should_sell'
    end

    # Calculates the order that should be placed given the current
    # trader state.
    # @return {array} an array of [price, quantity]
    def calc_buy_order(trade_context)
      raise NotImplementedError, 'unimplemented method calc_buy_order'
    end

    # Calculates the order that should be placed given the current
    # trader state.
    # @return {array} an array of [price, quantity]
    def calc_sell_order(trade_context)
      raise NotImplementedError, 'unimplemented method calc_sell_order'
    end

    # returns true if at least one order should be cancelled
    def should_cancel(trade_context)
      raise NotImplementedError, "unimplemented method should_cancel"
    end

    # returns the orders that should be cancelled
    def get_orders_to_cancel(trade_context)
      raise NotImplementedError, "unimplemented method get_orders_to_cancel"
    end

  end

end
