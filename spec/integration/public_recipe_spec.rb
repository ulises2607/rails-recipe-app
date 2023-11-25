require 'rails_helper'
RSpec.describe 'User', type: :system do
  describe 'Public reccipe' do
    let(:recipe) do
      Recipe.create(name: 'cake', preparation_time: 20, cooking_time: 10, description: 'Cake recipe', public: true,
                    user_id: 1, id: 1)
    end

    describe 'testing public recipe page rendering' do
      it 'should render the public recipe path' do
        visit '/public_recipes'
        expect(page).to have_current_path('/public_recipes')
      end
    end
  end
end
