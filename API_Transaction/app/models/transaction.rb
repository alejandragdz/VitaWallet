class Transaction < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :sender, :receiver, :coin_to_send, :coin_to_receive, :amount_to_send, :amount_to_receive, presence: true
  validates :amount_to_send, :amount_to_receive, numericality: true
end
