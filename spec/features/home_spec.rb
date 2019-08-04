# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Features', type: :feature do
  before(:each) do
    @user = create(:user)
    @user.confirm

    sign_in @user
  end

  scenario 'home page contains logged in user name and title `My Transactions`' do
    visit root_path

    expect(page).to have_text('Foo Bar')
    expect(page).to have_text('My Transactions')
  end

  scenario 'A newly registered (confirmed) user has the initial +1000 USD in his/her transactions' do
    visit root_path

    expect(page).to have_text('+1000.0')
  end
end
