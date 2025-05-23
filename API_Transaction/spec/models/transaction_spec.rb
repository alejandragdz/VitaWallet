require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'has_factory' do
    expect(create(:transaction)).to be_persisted
  end

  it "is not valid without a sender" do
    transaction = Transaction.new(
      sender: nil,
      receiver: create(:user),
      coin_to_send: 'usd',
      coin_to_receive: 'btc',
      amount_to_send: 100)
    expect(transaction).to_not be_valid
  end

  it "is not valid without a receiver" do
    transaction = Transaction.new(
      receiver: nil,
      sender: create(:user),
      coin_to_send: 'usd',
      coin_to_receive: 'btc',
      amount_to_send: 100)
    expect(transaction).to_not be_valid
  end

  it "is not valid without a coin_to_send" do
    transaction = Transaction.new(
      coin_to_send: nil,
      sender: create(:user),
      receiver: create(:user),
      coin_to_receive: 'btc',
      amount_to_send: 100)
    expect(transaction).to_not be_valid
  end

  it "is not valid without a coin_to_receive" do
    transaction = Transaction.new(
      coin_to_receive: nil,
      sender: create(:user),
      receiver: create(:user),
      coin_to_send: 'btc',
      amount_to_send: 100)
    expect(transaction).to_not be_valid
  end

  it "is not valid without a amount_to_send" do
    transaction = Transaction.new(
      amount_to_send: nil,
      sender: create(:user),
      receiver: create(:user),
      coin_to_send: 'btc',
      coin_to_receive: 'usd')
    expect(transaction).to_not be_valid
  end

  it "is not valid if amount_to_send is not a number" do
    transaction = Transaction.new(
      amount_to_send: "10",
      sender: create(:user),
      receiver: create(:user),
      coin_to_send: 'btc',
      coin_to_receive: 'usd')
    expect(transaction).to_not be_valid
  end
end
