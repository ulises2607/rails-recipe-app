require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { FactoryBot.build(:food) }

  context 'validations' do
    context 'presence' do
      it 'requires a name' do
        food.name = nil
        expect(food).not_to be_valid
      end

      it 'requires a unit' do
        food.unit = nil
        expect(food).not_to be_valid
      end

      it 'requires a price' do
        food.price = nil
        expect(food).not_to be_valid
      end

      it 'requires a quantity' do
        food.quantity = nil
        expect(food).not_to be_valid
      end
    end

    context 'numericality' do
      it 'requires a valid price' do
        food.price = 'abc'
        expect(food).not_to be_valid
      end

      it 'requires a valid quantity' do
        food.quantity = 'abc'
        expect(food).not_to be_valid
      end
    end
  end
end
