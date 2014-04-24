# this file exports the current bids to csv format
# The format is as follows:
# <price>,<amount>
# The output is sent to the standard output so that it can be manipulated by
# other bash programs

require 'weary'
require 'json'
require './bitbid/app/models/apis/cex_io.rb'

cexio = CexIO.new
bids = cexio.order_book['bids']
lines = bids.map  {|bid| "#{bid[0]},#{bid[1]}"}


puts lines.join("\n")
