require './app/models/apis/cex_io.rb'

class Ask < ActiveRecord::Base

    def Ask.fetch
        cexio = CexIO.new
        asks = cexio.order_book['asks']
        now = Time.now
        asks.each do |a|
            ask = Ask.new
            ask.price = a[0]
            ask.amount = a[1]
            ask.created_at = now
            ask.save
        end
    end
end
