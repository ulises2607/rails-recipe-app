class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show destroy]

  def index
    @recipe_foods = RecipeFood.all
  end

  def show
    recipe_food = RecipeFood.find(params[:id])
    redirect_to recipe_path(recipe_food.recipe)
  end

  def new
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    @foods = @user.food
    @recipe_food = @recipe.recipe_food.build

    @ingredients = @foods.map { |food| ["#{food.name} in #{food.unit}", food.id] }
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_food.build(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.destroy
      flash[:notice] = 'Food was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete food.'
    end
    redirect_to recipes_path, notice: 'Food was successfully deleted.'
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
