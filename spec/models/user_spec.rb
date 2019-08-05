# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before(:all) do
      @user = build(:user)
    end

    context 'when attributes are valid' do
      it 'is valid' do
        expect(@user).to be_valid
      end
    end

    context 'when attributes are not valid' do
      it 'is not valid without an email' do
        @user.email = nil
        expect(@user).to_not be_valid
      end

      it 'is not valid without a password' do
        @user.password = nil
        expect(@user).to_not be_valid
      end

      it 'is not valid without a name' do
        @user.name = nil
        expect(@user).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it { should have_many(:outgoing_transfers).dependent(:destroy) }
    it { should have_many(:incoming_transfers).dependent(:destroy) }
  end

  describe '#transfers' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    it 'returns users both sent and received transactions' do
      create_list(:transfer, 2, sender_id: user2.id, receiver_id: user1.id)
      create(:transfer, sender_id: user1.id, receiver_id: user2.id)
      create(:transfer, receiver_id: user2.id)

      expect(user1.transfers.count).to eq(3)
      expect(user2.transfers.count).to eq(4)
    end
  end
end
