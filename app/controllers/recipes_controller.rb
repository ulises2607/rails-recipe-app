class RecipesController < ApplicationController
  before_action :find_recipe, only: %i[show destroy update]
  before_action :authenticate_user!

  def index
    @recipes = Recipe.includes(:user).where(user_id: current_user.id)
    puts "El usuario es #{current_user.id}"
  end

  def show
    unless @recipe.public || current_user == @recipe.user
      redirect_to root_path, alert: 'You cannot access it.'
      return
    end
    @recipe_foods = @recipe.recipe_food
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipe.new(recipe_params)
    puts "Recipe Parameters: #{recipe_params.inspect}"
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        puts @recipe.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    puts 'Receta eliminada correctamente' if @recipe.destroyed?
    redirect_to recipes_path
  end

  def update
    @recipe.toggle!(:public)
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end

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
