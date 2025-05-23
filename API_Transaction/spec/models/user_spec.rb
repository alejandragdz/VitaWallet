require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) {create(:user)}

  it 'has_factory' do
    expect(create(:user)).to be_persisted
  end

  describe 'validations' do
    # it { should have_many(:transactions)}

    it 'validate__usd_balance' do
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
end
