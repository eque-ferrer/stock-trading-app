require 'rails_helper'

RSpec.describe Stock, type: :model do
  it "1. should not save without name" do 
    stock = Stock.new 
    stock.symbol = "NewStock"
    stock.current_price = 12.34
    stock.name = nil 

    expect(stock).to_not be_valid
    expect(stock.errors).to be_present
    expect(stock.errors.to_hash.keys).to include(:name)
  end 

  it "2. should not save without price" do 
    stock = Stock.new 
    stock.symbol = "NewStock"
    stock.current_price = nil
    stock.name = "New Stock Corp."

    expect(stock).to_not be_valid
    expect(stock.errors).to be_present
    expect(stock.errors.to_hash.keys).to include(:current_price)
  end 

  it "3. should not save without symbol" do 
    stock = Stock.new 
    stock.symbol = nil
    stock.current_price = 12.34
    stock.name = "New Stock Corp."

    expect(stock).to_not be_valid
    expect(stock.errors).to be_present
    expect(stock.errors.to_hash.keys).to include(:symbol)
  end 
  
end
