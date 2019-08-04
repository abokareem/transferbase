# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  let!(:user) { create(:user) }
  let(:transfer) { create(:transfer, receiver: user, amount: 1_000.0) }

  describe '#display_amount' do
    context 'initial transaction for newly registered user' do
      it 'has an amount with + sign' do
        expect(display_amount(transfer.amount, transfer.receiver, user)).to eq("<span class='green'>+1000.0</span>")
      end
    end
  end
end
