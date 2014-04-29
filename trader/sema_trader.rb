# Also known as the Simple exponential moving average trader
# This is an attempt to make a working GHS/BTC trader on relatively
# low time frames (around 1 minute windows).
#
# The Strategy
# This trader's strategy is very simple, itworks as follows:
#
# It trades only 1 trade at a time of 1 GHS, i.e. at any time there is either
# one open bid or one open ask.
#
# This Trader is extremely simple so as soon as it enters the market it will try
# to sell 1 GHS at the highest paying price.
#
# As soon as the GHS is sold, it will then record the price at which the GHS was sold and
# simply wait until there is a slight price change and then, sell the GHS.
#
module Trader
  class SemaTrader < SemaTrader

    attr_reader :sell_mode

    def start
      @sell_mode = true # start selling
      @quantity = 1 # always buy and sell 1 GHS
    end

    def current_ghs(trade_context)
      trade_context.current_available('BTC')
    end

    def current_btc(trade_context)
      trade_context.current_available('GHS')
    end

    def should_buy(trade_context)
      if @should_sell
        return false
      else
        # TODO
        return false
      end
    end

    def should_sell(trade_context)
      if @should_sell
        # TODO
        return false
      else
        return false
      end
    end

    # trade at a price such that the trade can be finished immediately
    def calc_buy_order(trade_context)
      sorted = trade_context.asks.sort
      quant = 0
      prices = []
      sorted.each do |ask|
        prices.push ask[0]
        quant += ask[1]
        if quant > @quantity
          break
        end
      end
      price = prices.reduce(:+)/prices.size
      order = [price, @quantity]

      puts "placing buy order of #{order}"
      return order
    end

    def calc_sell_order(trade_context)
      sorted = trade_context.asks.sort.reverse
      quant = 0
      prices = []
      sorted.each do |ask|
        prices.push ask[0]
        quant += ask[1]
        if quant > @quantity
          break
        end
      end
      price = prices.reduce(:+)/prices.size
      order = [price, @quantity]

      puts "placing sell order of #{order}"
      return order
    end

    def should_cancel(trade_context)
      return false
    end

    def get_orders_to_cancel(trade_context)
      trade_context.active_order_ids
    end

    def self.create
      api = CEX::API.new ENV['cex_username'], ENV['cex_api_key'], ENV['cex_api_secret']
      sleep_period = 8 # measured in seconds
      log = Logger.new STDOUT
      trade_context = TradeContext.new api: api
      SemaTrader.new log: log, sleep_period: sleep_period, trade_context: trade_context, api: api
    end
  end
end
