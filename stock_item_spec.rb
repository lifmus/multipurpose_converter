require 'rspec'
require './stock_item.rb'

describe StockItem do
  it "returns a formatted hash with nested modifiers" do
    header_row               = ["id", "description", "price", "cost", "price_type", "quantity_on_hand", "modifier_1_name", "modifier_1_price", "modifier_2_name", "modifier_2_price", "modifier_3_name", "modifier_3_price"] 
    data_row                 = ["111010", "Coffee", "$1.25", "$0.80", "system", "100000", "Small", "-$0.25", "Medium", "$0.00", "Large", "$0.30"] 
    stock_item               = StockItem.new(header_row, data_row)
    correctly_formatted_hash = {"id"=>"111010", "description"=>"Coffee", "price"=>"$1.25", "cost"=>"$0.80", "price_type"=>"system", "quantity_on_hand"=>"100000", "modifiers"=>[{"name"=>"Small", "price"=>"-$0.25"}, {"name"=>"Medium", "price"=>"$0.00"}, {"name"=>"Large", "price"=>"$0.30"}]} 
    expect(stock_item.formatted_hash).to eq(correctly_formatted_hash)
  end

  it "returns an empty modifier array if there are no modifiers" do
    header_row               = ["id", "description", "price", "cost", "price_type", "quantity_on_hand", "modifier_1_name", "modifier_1_price", "modifier_2_name", "modifier_2_price", "modifier_3_name", "modifier_3_price"] 
    data_row                 = ["2847225", "Milk 49", "$70.00", "49", "system", "510"] 
    stock_item               = StockItem.new(header_row, data_row)
    expect(stock_item.formatted_hash["modifiers"]).to eq([])
  end
end
