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
end
