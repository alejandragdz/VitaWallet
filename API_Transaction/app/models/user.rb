class User < ApplicationRecord
  has_many :transactions
  validates :name, presence: true

  def transactions
    Transaction.where("sender_id = id")
  end
end
