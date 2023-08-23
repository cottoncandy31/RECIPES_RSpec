# spec/controllers/admin/users_controller_spec.rb
require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin_user) { create(:admin_user) }  # Assuming you have a factory for admin users

  describe 'GET #index' do
    context 'with search_email parameter' do
      it 'returns a successful response' do
        sign_in admin_user
        get :index, params: { search_email: 'example@example.com' }
        expect(response).to have_http_status(:success)
      end
    end

    context 'without search_email parameter' do
      it 'returns a successful response' do
        sign_in admin_user
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a successful response' do
      user = create(:user)  # Assuming you have a factory for normal users
      sign_in admin_user
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = create(:user)
      sign_in admin_user
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    it 'updates user is_deleted flag and redirects' do
      user = create(:user)
      sign_in admin_user
      patch :update, params: { id: user.id }
      user.reload
      expect(user.is_deleted).to eq(true)
      expect(flash[:notice]).to eq('退会処理を実行いたしました')
      expect(response).to redirect_to(admin_users_path)
    end
  end
end
