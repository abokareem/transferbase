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
end
