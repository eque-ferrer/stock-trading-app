class Stock < ApplicationRecord
  validates :symbol, presence:true       
  validates :name, presence:true       
  validates :current_price, presence:true       

  has_many :user_stocks
  has_many :users, through: :user_stocks

end
