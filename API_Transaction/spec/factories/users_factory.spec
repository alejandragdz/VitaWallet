FactoryBot.define do
  factory :user do
    name { 'John' }
    usd_wallet  { 150.00 }
    btc_wallet  { 31.01491002 }
  end
end