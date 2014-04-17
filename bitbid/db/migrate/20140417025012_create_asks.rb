class CreateAsks < ActiveRecord::Migration
  def change
    create_table :asks do |t|
      t.float :price
      t.float :amount

      t.timestamps
    end
  end
end
