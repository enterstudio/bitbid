class Bid < ActiveRecord::Base

    def Bid.fetch
        cexio = CexIO.new
        asks = cexio.order_book['bids']
        asks.each do |a|
            ask = Bid.new
            ask.price = a[0]
            ask.amount = a[1]
            ask.save
        end
    end

end
