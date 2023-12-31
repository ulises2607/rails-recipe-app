class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @foods = current_user.food.includes(:recipe_foods)
  end

  def show; end

  def new
    @food = Food.new
  end

  def edit; end

  def create
    @food = Food.new(food_params.except(:recipe_food_quantity))
    @food.user = current_user

    respond_to do |format|
      if @food.save
        if params[:food][:recipe_id]
          RecipeFood.create(recipe: Recipe.find(params[:food][:recipe_id]), food: @food,
                            quantity: params[:food][:recipe_food_quantity])
        end
        format.html { redirect_to request.referrer, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { redirect_to request.referrer, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to foods_path, notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe_foods = @food.recipe_foods
    @recipe_foods.destroy_all
    @food.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :unit, :price, :quantity)
  end
end
