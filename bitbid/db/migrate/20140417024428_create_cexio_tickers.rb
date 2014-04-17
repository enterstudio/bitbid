class CreateCexioTickers < ActiveRecord::Migration
  def change
    create_table :cexio_tickers do |t|
      t.float :last
      t.float :high
      t.float :low
      t.float :volume
      t.float :bid
      t.float :ask

      t.timestamps
    end
  end
end
