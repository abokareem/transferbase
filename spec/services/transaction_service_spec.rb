# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionService do
  describe '#finalize_transaction' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:transfer) { build(:transfer, sender_id: user1.id, receiver_id: user2, target_currency: target_currency) }

    before do
      stub_200(:get, default_uri)
    end

    context 'USD' do
      let(:target_currency) { 'USD' }

      it 'successfully transfers USD' do
        TransactionService.new(transfer).finalize_transaction
        expect(transfer.status).to eq(Transfer::SUCCESS)
        expect(transfer.exchange_rate).to eq(1.0)
      end
    end

    context 'EUR' do
      let(:target_currency) { 'EUR' }

      it 'successfully transfers EUR' do
        TransactionService.new(transfer).finalize_transaction
        expect(transfer.status).to eq(Transfer::SUCCESS)
        expect(transfer.exchange_rate).to eq(0.9004141905)
      end
    end

    context 'EUR' do
      let(:target_currency) { 'GBP' }

      it 'successfully transfers GBP' do
        TransactionService.new(transfer).finalize_transaction
        expect(transfer.status).to eq(Transfer::SUCCESS)
        expect(transfer.exchange_rate).to eq(0.823924005)
      end
    end
  end
end
