class User < ApplicationRecord
  has_many :transactions
  validates :name, presence: true

  def transactions
    Transaction.where(sender_id: id)
  end

  def validate_balance(coin, amount)
    return amount <= btc_wallet if coin == 'btc'
    return amount <= usd_wallet if coin == 'usd'
    return false
  end

  def update_wallet(coin, sender, amount)
      if sender
        amount = amount * -1
      end

      if coin == 'usd'
        update(usd_wallet: usd_wallet+amount)
      else
        update(btc_wallet: btc_wallet+amount)
      end
    end
end
