# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionService do
  describe '#finalize_transaction' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:transfer1) { create(:transfer, receiver_id: user2.id, target_currency: 'USD', amount: 1000.0, status: Transfer::SUCCESS) }
    let(:transfer2) { build(:transfer, sender_id: user2.id, receiver_id: user1.id, target_currency: target_currency, amount: 100.0) }

    before do
      stub_200(:get, default_uri)
    end

    context 'USD' do
      let(:target_currency) { 'USD' }

      it 'successfully transfers USD' do
        TransactionService.new(transfer2).finalize_transaction
        expect(transfer2.status).to eq(Transfer::SUCCESS)
        expect(transfer2.exchange_rate).to eq(1.0)
      end
    end

    context 'EUR' do
      let(:target_currency) { 'EUR' }

      it 'successfully transfers EUR' do
        TransactionService.new(transfer2).finalize_transaction
        expect(transfer2.status).to eq(Transfer::FAILURE)
        expect(transfer2.exchange_rate).to eq(0.90)
      end
    end

    context 'GBP' do
      let(:target_currency) { 'GBP' }

      it 'successfully transfers GBP' do
        TransactionService.new(transfer2).finalize_transaction
        expect(transfer2.status).to eq(Transfer::FAILURE)
        expect(transfer2.exchange_rate).to eq(0.823)
      end
    end

    context 'User cannot have negative balance' do
      it 'should fail the transaction when balance is not enough' do
        transfer3 = build(:transfer, sender_id: user2.id, receiver_id: user1.id, amount: 2000.0, target_currency: 'USD')
        TransactionService.new(transfer3).finalize_transaction
        expect(transfer3.status).to eq(Transfer::FAILURE)
      end
    end
  end
end
