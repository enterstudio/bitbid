require 'logger'
require_relative 'cex_trader'
require_relative 'trade_context'

module Trader

  class ReadonlyTrader < CexTrader

    def ReadonlyTrader.create
      api = CEX::API.new ENV['cex_username'], ENV['cex_api_key'], ENV['cex_api_secret']
      sleep_period = 10 # measured in seconds
      log = Logger.new STDOUT
      trade_context = TradeContext.new api: api
      return ReadonlyTrader.new(log: log, sleep_period: sleep_period, trade_context: trade_context, api: api)
    end

    def on_data_loaded(trade_context)
      # fetch the average price of the 5 cheapest asks
      # fetch the average price of the 5 highest bids
      min_ask = trade_context.min_ask(5)
      max_bid = trade_context.max_bid(5)
      spread = trade_context.spread

      @log.info "min5:#{min_ask}, max5:#{max_bid},spread:#{spread}"
    end

    # never buy
    def should_buy(trade_context)
      return false
    end

    # never sell
    def should_sell(trade_context)
      return false
    end

    # never cancel orders
    def should_cancel(trade_context)
      return false
    end

    # always return an empty array
    def get_orders_to_cancel(trade_context)
      return []
    end

    def calc_buy_order(trade_context)
      return nil
    end

    def calc_sell_order(trade_context)
      return nil
    end

  end

end
