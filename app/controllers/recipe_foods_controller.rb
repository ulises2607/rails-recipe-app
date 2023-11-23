class RecipeFoodsController < ApplicationController
    before_action :set_recipe_food, only: %i[show edit update destroy]

    def index
        @recipe_foods = RecipeFood.all
    end

    def show
    end

    def new
        @recipe_food = RecipeFood.new
    end

    def create
        @recipe = Recipe.find(params[:recipe_id])
        @recipe_food = RecipeFood.new(recipe_food_params)
        @recipe_food.food.update(quantity: params[:recipe_food][:quantity])
        @recipe_food.recipe = @recipe

        if @recipe_food.save
            redirect_to recipe_path(@recipe)
        else
            render :new
        end
    end

    def destroy
        @recipe_food.destroy
        redirect_to recipe_path(@recipe_food.recipe)
    end




    private

    def set_recipe_food
      @recipe_food = RecipeFood.find(params[:id])
    end

    def recipe_food_params
        params.require(:recipe_food).permit(:food_id, :quantity)
    end


end
