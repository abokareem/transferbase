# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before(:each) do
    @user = create(:user)
    @user.confirm

    sign_in @user
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
