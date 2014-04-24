class MockCexApi

  attr_reader :orders_to_cancel
  attr_reader :orders

  def initialize
    @orders_to_cancel = []
    @orders = []
  end

  # Adds a new 'cancel' order, which is just adding the id to the list of @orders_to_cancel
  def cancel_order(id)
    @orders_to_cancel.push id
  end

  def place_order(type, amount, price, couple)
    order = { :type => type, :amount => amount, :price => price, :couple => couple }
    @orders.push order
  end

  def order_book(couple)
    return { :bids => [], :asks=> [] }
  end

  def trade_history(since, couple)
    return []
  end

  def open_orders()
    return []
  end

  def balance
    return {}
  end

  def clear
    @orders.clear
    @orders_to_cancel.clear
  end
end
