# this file exports the current trades to csv format
# The format is as follows:
# <price>,<amount>
# The output is sent to the standard output so that it can be manipulated by
# other bash programs

require 'weary'
require 'json'
require './bitbid/app/models/apis/cex_io.rb'

cexio = CexIO.new
trades = cexio.trade_history
lines = trades.map  {|trade| "#{trade['price']},#{trade['amount']}"}


puts lines.join("\n")
