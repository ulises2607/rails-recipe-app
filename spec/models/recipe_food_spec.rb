require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  let(:recipe_food) { FactoryBot.build(:recipe_food) }

  it 'is not valid without a food_id' do
    recipe_food.food_id = nil
    expect(recipe_food).not_to be_valid
  end

  it 'is not valid without a recipe_id' do
    recipe_food.recipe_id = nil
    expect(recipe_food).not_to be_valid
  end
end
