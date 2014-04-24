# this file exports the current asks to csv format
# The format is as follows:
# <price>,<amount>
# The output is sent to the standard output so that it can be manipulated by
# other bash programs

require 'weary'
require 'json'
require './bitbid/app/models/apis/cex_io.rb'

cexio = CexIO.new
asks = cexio.order_book['asks']
lines = asks.map  {|ask| "#{ask[0]},#{ask[1]}"}


puts lines.join("\n")
