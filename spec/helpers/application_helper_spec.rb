# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let(:transfer) { create(:transfer, receiver: user, amount: 1_000.0) }

  describe '#display_amount' do
    context 'initial transaction for newly registered user' do
      it 'has an amount with + sign' do
        expect(display_amount(transfer.amount, transfer.receiver, user)).to eq("<span class='green'>+1000.0</span>")
      end
    end

    it 'outgoing transactions have an amount with - sign' do
      transfer = create(:transfer, sender_id: user.id, receiver_id: user2.id, amount: 200.0)
      expect(display_amount(transfer.amount, transfer.receiver, user)).to eq("<span class='red'>-200.0</span>")
    end
  end

  describe '#transaction_status' do
    it 'displays successful transaction status' do
      transfer.status = Transfer::SUCCESS
      expect(transaction_status(transfer.status)).to eq('Completed')
    end

    it 'displays failed transaction status' do
      transfer.status = Transfer::FAILURE
      expect(transaction_status(transfer.status)).to eq('Cancelled')
    end
  end

  describe '#formatted_date' do
    it 'displays formatted date for created transactions' do
      date = DateTime.new(2019, 8, 4, 13, 17)
      expect(formatted_date(date)).to eq('August 4, 2019 13:17')
    end
  end

  describe '#display_status' do
    it 'displays cancelled status in red color' do
      status = 'Cancelled'
      expect(display_status(status)).to eq("<span class='red'>Cancelled</span>")
    end

    it 'displays cancelled status in red color' do
      status = 'Completed'
      expect(display_status(status)).to eq('Completed')
    end
  end
end
