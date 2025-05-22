require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has_factory' do
    expect(create(:user)).to be_persisted
  end
end
