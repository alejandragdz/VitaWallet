class User < ApplicationRecord
  has_many :transactions
  validates :name, presence: true

  def transactions
    Transaction.where("sender_id = id")
  end

  def validate_balance(coin, amount)
    return amount <= btc_wallet if coin == 'btc'
    return amount <= usd_wallet if coin == 'usd'
    return false
  end
end
