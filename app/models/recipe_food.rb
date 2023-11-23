class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  validates :food_id, recipe_id, presence: true
end
