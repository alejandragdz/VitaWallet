FactoryBot.define do
  factory :user do
    name { 'John' }
    usd_wallet  { 150.00 }
    btc_wallet  { 31.01491002 }
  end

  factory :second_user, class: User do
    name { 'Robert' }
    usd_wallet  { 200.00 }
    btc_wallet  { 100.01491002 }
  end
end