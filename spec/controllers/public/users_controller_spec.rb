require 'rails_helper'

RSpec.describe Public::UsersController, type: :controller do
  describe 'GET #show' do
    let(:user) { create(:user) }

    it 'returns a successful response' do
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns @user' do
      sign_in user
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns @recipes' do
      recipe1 = create(:recipe, user: user)
      recipe2 = create(:recipe, user: user)
      sign_in user
      get :show, params: { id: user.id }
      expect(assigns(:recipes)).to eq([recipe2, recipe1])
    end

    it 'assigns @users' do
      other_user = create(:user)
      sign_in user
      get :show, params: { id: user.id }
      expect(assigns(:users)).to eq([user, other_user])
    end
  end
end
