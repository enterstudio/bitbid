class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.string :tid
      t.float :amount
      t.float :price
      t.datetime :date

      t.timestamps
    end
  end
end
