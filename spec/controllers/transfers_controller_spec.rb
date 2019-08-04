# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  before(:each) do
    @user = create(:user)
    @user.confirm

    sign_in @user
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before do
        stub_200(:get, default_uri)
      end

      it 'creates transfer' do
        @user2 = create(:user)

        expect do
          post :create, params: { transfer: FactoryBot.attributes_for(:transfer, receiver_id: @user2.id) }
        end.to change(Transfer, :count).by(1)

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid attributes' do
      before do
        stub_200(:get, default_uri)
      end

      it 'creates transfer' do
        expect do
          post :create, params: { transfer: FactoryBot.attributes_for(:transfer) }
        end.to change(Transfer, :count).by(0)

        expect(response).to render_template(:new)
      end
    end

    context 'with unsuccessful exchange rate api response' do
      before do
        stub_422(:get, default_uri)
      end

      it 'creates transfer' do
        @user2 = create(:user)

        expect do
          post :create, params: { transfer: FactoryBot.attributes_for(:transfer, receiver_id: @user2) }
        end.to change(Transfer, :count).by(0)

        expect(response).to render_template(:new)
      end
    end
  end
end
