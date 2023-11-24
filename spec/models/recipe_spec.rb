require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject { FactoryBot.create(:recipe) }

  before { subject.save }

  it 'should have a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'should have a valid preparation time' do
    subject.preparation_time = nil
    expect(subject).not_to be_valid
  end

  it 'should have a valid cooking time' do
    subject.cooking_time = nil
    expect(subject).not_to be_valid
  end
end