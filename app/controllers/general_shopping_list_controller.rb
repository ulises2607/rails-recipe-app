class GeneralShoppingListController < ApplicationController
  def index
    @foods = Food.where(user: current_user)
    @recipes = Recipe.includes(:recipe_food).where(user: current_user)
    @recipe_foods = []
    @recipes.each do |recipe|
      recipe.recipe_food.each do |recipe_food|
        @recipe_foods << recipe_food
      end
    end
    foods_in_recipes_ids = @recipe_foods.map(&:food_id).uniq
    @missing_foods = @foods.where.not(id: foods_in_recipes_ids)
  end
end
