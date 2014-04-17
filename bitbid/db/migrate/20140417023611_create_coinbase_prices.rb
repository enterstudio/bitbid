class CreateCoinbasePrices < ActiveRecord::Migration
  def change
    create_table :coinbase_prices do |t|
      t.float :buy_price
      t.float :sell_price

      t.timestamps
    end
  end
end
