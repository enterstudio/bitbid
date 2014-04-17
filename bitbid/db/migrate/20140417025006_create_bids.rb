class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :price
      t.float :amount

      t.timestamps
    end
  end
end
