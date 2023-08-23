# spec/controllers/admin/reports_controller_spec.rb
require 'rails_helper'

RSpec.describe Admin::ReportsController, type: :controller do
  let(:admin_user) { create(:admin_user) }  # Assuming you have a factory for admin users

  describe 'GET #index' do
    it 'returns a successful response' do
      sign_in admin_user
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @reports in descending order of creation' do
      sign_in admin_user
      report1 = create(:report)
      report2 = create(:report)
      get :index
      expect(assigns(:reports)).to eq([report2, report1])
    end

    it 'assigns @users' do
      sign_in admin_user
      user1 = create(:user)
      user2 = create(:user)
      get :index
      expect(assigns(:users)).to eq([user1, user2])
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      report = create(:report)
      sign_in admin_user
      get :show, params: { id: report.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns @report, @reported, and @reporter' do
      reported_user = create(:user)
      reporter_user = create(:user)
      report = create(:report, reported_id: reported_user.id, reporter_id: reporter_user.id)
      sign_in admin_user
      get :show, params: { id: report.id }
      expect(assigns(:report)).to eq(report)
      expect(assigns(:reported)).to eq(reported_user)
      expect(assigns(:reporter)).to eq(reporter_user)
    end
  end

  describe 'PATCH #update' do
    it 'updates the report and redirects' do
      report = create(:report)
      sign_in admin_user
      patch :update, params: { id: report.id, report: { check: true } }
      report.reload
      expect(report.check).to eq(true)
      expect(response).to redirect_to(admin_reports_path)
    end
  end
end
