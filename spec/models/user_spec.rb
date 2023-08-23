require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe 'associations' do
    it { should have_many(:recipes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:favorites).dependent(:destroy) }
    it { should have_many(:bookmarks).dependent(:destroy) }
    it { should have_many(:bookmarked_recipes).through(:bookmarks).source(:recipe) }
    it { should have_many(:reporter).class_name("Report").with_foreign_key("reporter_id").dependent(:destroy) }
    it { should have_many(:reported).class_name("Report").with_foreign_key("reported_id").dependent(:destroy) }
  end

  describe 'methods' do
    let(:user) { create(:user) }  

    it '#follow, #unfollow, #following?' do
      other_user = create(:user)  
      user.follow(other_user.id)
      expect(user.following?(other_user)).to be true

      user.unfollow(other_user.id)
      expect(user.following?(other_user)).to be false
    end

    it '#guest?' do
      expect(user.guest?).to be false
      guest_user = User.new(email: 'guest@example.com')
      expect(guest_user.guest?).to be true
    end

    it '#active_for_authentication?' do
      user.update(is_deleted: false)
      expect(user.active_for_authentication?).to be true

      user.update(is_deleted: true)
      expect(user.active_for_authentication?).to be false
    end
  end
end
