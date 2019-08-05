# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transfer, type: :model do
  describe 'validations' do
    before(:all) do
      @transfer = build(:transfer)
    end

    context 'when attributes are valid' do
      it 'is valid' do
        expect(@transfer).to be_valid
      end
    end

    context 'when attributes are not valid' do
      it 'is not valid without an amount' do
        @transfer.amount = nil
        expect(@transfer).to_not be_valid
      end

      it 'is not valid without a source_currency' do
        @transfer.source_currency = nil
        expect(@transfer).to_not be_valid
      end

      it 'is not valid without a target_currency' do
        @transfer.target_currency = nil
        expect(@transfer).to_not be_valid
      end

      it 'is not valid without a exchange_rate' do
        @transfer.exchange_rate = nil
        expect(@transfer).to_not be_valid
      end

      it 'is not valid without a status' do
        @transfer.status = nil
        expect(@transfer).to_not be_valid
      end

      it 'is not valid with a status other than failure or success' do
        @transfer.status = 5
        expect(@transfer).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:sender).optional }
    it { should belong_to(:receiver) }
  end

  describe '.current_balance' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }

    it 'returns current balance for USD, EUR and GBP' do
      create_list(:transfer, 2, sender_id: user2.id, receiver_id: user1.id, amount: 100.0, target_currency: 'GBP', status: Transfer::SUCCESS)
      create_list(:transfer, 2, sender_id: user2.id, receiver_id: user1.id, amount: 250.0, target_currency: 'EUR', status: Transfer::SUCCESS)
      create(:transfer, sender_id: user1.id, receiver_id: user2.id, amount: 150.0, target_currency: 'EUR', status: Transfer::SUCCESS)
      create(:transfer, sender_id: user2.id, receiver_id: user1.id, amount: 150.0, target_currency: 'USD', status: Transfer::SUCCESS)

      expect(Transfer.current_balance(user1)).to eq('EUR' => 350.0, 'GBP' => 200.0, 'USD' => 150.0)
    end
  end
end
