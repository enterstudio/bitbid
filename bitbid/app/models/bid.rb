class Bid < ActiveRecord::Base

    def Bid.fetch
        cexio = CexIO.new
        bids = cexio.order_book['bids']
        now = Time.now
        bids.each do |a|
            bid = Bid.new
            bid.price = a[0]
            bid.amount = a[1]
            bid.created_at = now
            bid.save
        end
    end

end
