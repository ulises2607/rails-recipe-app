class PublicRecipesController < ApplicationController

    def index
        @recipes = Recipe.all
        @public_recipes = @recipes.where(public: true)
        @recipe_foods = RecipeFood.all.where(recipe_id: @public_recipes.ids)

    end

end
