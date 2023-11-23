class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = Recipe.all.where(user_id: current_user.id)
    puts "El usuario es #{current_user.id}"
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    puts 'Receta eliminada correctamente' if @recipe.destroyed?
    redirect_to recipes_path(@recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :preparation_time,
      :cooking_time,
      :description,
      :public,
      :user_id
    )
  end
end
