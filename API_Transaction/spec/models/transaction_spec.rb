require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it 'has_factory' do
    expect(create(:transaction)).to be_persisted
  end
end
