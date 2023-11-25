class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_food, dependent: :destroy
  has_many :food, through: :recipe_food

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true }
  validates :cooking_time, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
  validates :public, presence: true, inclusion: { in: [true, false] }
  validates :user_id, presence: true

  def count_recipe_foods
    count = recipe_food.count
    sum_price = food.sum(:price)
    { count:, sum_price: }
  end
end
