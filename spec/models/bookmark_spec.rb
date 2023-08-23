# spec/models/bookmark_spec.rb
require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:recipe) }
  end

  describe 'validations' do
    subject { create(:bookmark) }  

    it { should validate_uniqueness_of(:user_id).scoped_to(:recipe_id) }
  end
end
