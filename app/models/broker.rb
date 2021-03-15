class Broker < User
  has_many :broker_stocks, class_name: "UserStock", foreign_key: :user_id
  has_many :stocks, through: :broker_stocks
end

