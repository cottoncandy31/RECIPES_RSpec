require 'rails_helper'

RSpec.describe Public::FavoritesController, type: :controller do
  let(:user) { create(:user) }  
  let(:recipe) { create(:recipe) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    it 'creates a favorite for the recipe' do
      post :create, params: { recipe_id: recipe.id }, format: :js
      expect(user.favorites.count).to eq(1)
    end
  end

  describe 'DELETE #destroy' do
    before do
      user.favorites.create(recipe_id: recipe.id)
    end

    it 'destroys the favorite for the recipe' do
      delete :destroy, params: { recipe_id: recipe.id }, format: :js
      expect(user.favorites.count).to eq(0)
    end
  end
end
