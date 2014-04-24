require 'logger'
require './trader/cex_trader.rb'
require './trader/trade_context.rb'
require_relative 'mocks/mock_cex_api.rb'

describe Trader::CexTrader do

  before :each do

    @api = MockCexApi.new
    log = Logger.new nil
    @trade_context = Trader::TradeContext.new api: @api
    @trader = Trader::CexTrader.new log:log, sleep_period: 0, trade_context: @trade_context, api: @api
  end

  # just a test to make sure everything is going ok
  it "should not be nil" do
    @trader.should_not be_nil
  end

  context "cancel_orders" do
    it "should call the API's cancel order method for each order" do
      order_ids = [1,2,3,4,5,6]
      @trader.cancel_orders order_ids
      @api.orders_to_cancel.should eq(order_ids)
    end
  end

  context "placing orders" do
    it "should place an order when place_sell_order is called" do
      price, amount = 0.0074, 234
      @trader.place_sell_order(price, amount)
      order = @api.orders.first
      order[:price].should eq(price)
      order[:amount].should eq(amount)
    end
    it "should place an order when place_buy_order is called" do
      price, amount = 0.0074, 234
      @trader.place_buy_order(price, amount)
      order = @api.orders.first
      order[:price].should eq(price)
      order[:amount].should eq(amount)
    end
  end

  context "termination" do
    it "should set should_terminated to true when calling the terminate method" do
      @trader.terminate
      @trader.should_terminate.should eq(true)
    end
  end

  context "unimplemented methods" do

    [:should_buy, :should_sell, :calc_buy_order, :calc_sell_order, :should_cancel, :get_orders_to_cancel].each do |method_name|
      it "should raise exception when calling #{method_name}" do
        expect { @trader.send(method_name,@trade_context) }.to raise_error(NotImplementedError)
      end
    end
  end

  context "when iterating" do

    before :each do
      [:should_buy, :should_sell, :should_cancel].each do |method|
        @trader.class.send :define_method, method do |trade_context|
          return true
        end
      end
      [:calc_buy_order, :calc_sell_order, :get_orders_to_cancel].each do |method|
        @trader.class.send :define_method, method do |trade_context|
          return [1,1]
        end
      end

   end

    it "should place a buy order if `should_buy` is true" do
      @trader.iterate run_once: true
      @api.orders.size.should eq(2)
      @api.orders.first[:type].should eq('buy')
    end

    it "should place a sell order if `should_sell` is true" do
      @trader.iterate run_once: true
      @api.orders.size.should eq(2)
      @api.orders.last[:type].should eq('sell')
    end

    it "should cancel an order if `should_cancel` is true" do
      @trader.iterate run_once: true
      @api.orders.size.should eq(2)
    end
  end
end



