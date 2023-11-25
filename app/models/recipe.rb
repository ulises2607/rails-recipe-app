class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_food, dependent: :destroy

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true }
  validates :cooking_time, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
  validates :public, presence: true, inclusion: { in: [true, false] }
  validates :user_id, presence: true
end
