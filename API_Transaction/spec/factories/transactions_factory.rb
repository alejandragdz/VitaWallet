FactoryBot.define do
  factory :transaction do
    coin_to_send { "MyString" }
    coin_to_receive { "MyString" }
    amount_to_send { "9.99" }
    amount_to_receive { "9.99" }
  end
end
