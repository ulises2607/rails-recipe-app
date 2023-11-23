class RecipesController < ApplicationController
    before_action :find_recipe, only: %i[show destroy update]
    before_action :authenticate_user!, except: %i[index show]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
        @recipe = Recipe.new(recipe_params)
        @recipe.user = current_user
        puts params.inspect
        if @recipe.save
            redirect_to recipe_path(@recipe)
        else
            render :new
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
