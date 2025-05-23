require 'rails_helper'

RSpec.describe User, type: :model do
  # let(:trn) {
  #   create(:transaction)
  # }

  # let(:usr) {
  #   trn.sender
  # }

  it 'has_factory' do
    expect(create(:user)).to be_persisted
  end

  # describe 'validations' do
  #   it { should have_many(:transactions)}
  # end
end
