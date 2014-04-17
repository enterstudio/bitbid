require './app/models/apis/cex_io.rb'

class CexioTicker < ActiveRecord::Base


    def CexioTicker.fetch
        cexio = CexIO.new
        ticker = cexio.ticker
        puts ticker

        ticker_model = CexioTicker.new
        ticker_model.last = ticker['last']
        ticker_model.high = ticker['high']
        ticker_model.low = ticker['low']
        ticker_model.volume = ticker['volume']
        ticker_model.bid = ticker['bid']
        ticker_model.ask = ticker['ask']

        ticker_model.save
    end

end
