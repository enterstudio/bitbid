require_relative 'readonly_trader'
require_relative 'cex_trader'

module Trader

  extend CexTrader
  extend ReadonlyTrader
end
