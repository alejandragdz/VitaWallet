FactoryBot.define do
  factory :transaction do
    coin_to_send { "usd" }
    coin_to_receive { "btc" }
    amount_to_send { 9.99 }
    sender { create(:user) }
    receiver { create(:second_user) }
  end
end
