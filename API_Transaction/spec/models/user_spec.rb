require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) {create(:user)}

  it 'has_factory' do
    expect(create(:user)).to be_persisted
  end

  describe 'validations' do
    it 'relation transactions' do
      transaction = Transaction.create(sender: user, receiver: create(:user), coin_to_send: 'usd', coin_to_receive: 'btc', amount_to_send: 1, amount_to_receive: 1)
      expect(user.transactions.length).to eq(1) 
      expect(user.transactions).to include(transaction) 
    end

    it 'validate_usd_balance' do
      # usd_wallet  { 150.00 }
      expect(user.validate_balance('usd', 150)).to eq(true)
      expect(user.validate_balance('usd', 100)).to eq(true)
      expect(user.validate_balance('usd', 151)).to eq(false)
    end

    it 'validate_btc_balance' do
      # btc_wallet  { 31.01491002 }
      expect(user.validate_balance('btc', 31.01491002)).to eq(true)
      expect(user.validate_balance('btc', 31)).to eq(true)
      expect(user.validate_balance('btc', 32)).to eq(false)
    end

    it 'validates_errors' do
      expect(user.validate_balance('bct', 10)).to eq(false)
      expect(user.validate_balance('ust', 10)).to eq(false)
    end
  end

  describe 'update_wallet' do
    it 'update_usd_wallet_sender' do
      # usd_wallet  { 150.00 }
      user.update_wallet('usd', true, 100)
      expect(user.usd_wallet).to eq(50.00)
    end

    it 'update_usd_wallet_receiver' do
      # usd_wallet  { 150.00 }
      user.update_wallet('usd', false, 100)
      expect(user.usd_wallet).to eq(250.00)
    end

    it 'update_btc_wallet_sender' do
      # btc_wallet  { 31.01491002 }
      user.update_wallet('btc', true, 10)
      expect(user.btc_wallet).to eq(21.01491002)
    end

    it 'update_btc_wallet_receiver' do
      # btc_wallet  { 31.01491002 }
      user.update_wallet('btc', false, 10)
      expect(user.btc_wallet).to eq(41.01491002)
    end
  end
end
