# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Features', type: :feature do
  before(:each) do
    @user = create(:user)
    @user.confirm

    sign_in @user
  end

  context 'home page contains' do
    before(:each) do
      visit root_path
    end

    it 'logged in user name' do
      expect(page).to have_text('Foo Bar')
    end

    it 'title `My Transactions`' do
      expect(page).to have_text('My Transactions')
    end

    it '`New Transaction` button' do
      expect(page).to have_button('New Transaction')
    end
  end

  scenario 'A newly registered (confirmed) user has the initial +1000 USD in his/her transactions' do
    visit root_path

    expect(page).to have_text('+1000.0')
  end
end
