# spec/models/step_spec.rb
require 'rails_helper'

RSpec.describe Step, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should have_one_attached(:step_image) }
    it { should have_many(:tags).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(200) }
  end
end

