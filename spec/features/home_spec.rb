# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Features', type: :feature do
  before(:each) do
    @user = create(:user)
    @user.confirm

    sign_in @user
  end

  scenario 'home page contains logged in user name' do
    visit root_path

    expect(page).to have_text('Foo Bar')
  end
end
