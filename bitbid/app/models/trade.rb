require './app/models/apis/cex_io.rb'

class Trade < ActiveRecord::Base

    validates :tid, uniqueness: true

    def Trade.fetch
        cexio = CexIO.new
        trade_history = cexio.trade_history
        trade_history.each do |t|
            trade = Trade.new
            trade.tid = t['tid']
            trade.amount = t['amount']
            trade.price = t['price']
            trade.date = Time.at(Integer(t['date']))
            trade.save
        end
    end

end
