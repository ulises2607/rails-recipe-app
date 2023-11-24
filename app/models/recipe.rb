class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_food, dependent: :destroy
  has_many :food, through: :recipe_food

  validates :name, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
  validates :description, presence: true

  def count_recipe_foods
    count = recipe_food.count
    sum_price = food.sum(:price)
    { count: count, sum_price: sum_price }
  end
end
