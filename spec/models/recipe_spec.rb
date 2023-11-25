require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject { FactoryBot.create(:recipe, public: true) }

  before { subject.save }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a preparation time' do
    subject.preparation_time = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a cooking time' do
    subject.cooking_time = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a description' do
    subject.description = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a user_id' do
    subject.user_id = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a boolean value for public' do
    subject.public = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid with a non-integer preparation time' do
    subject.preparation_time = 'abc'
    expect(subject).not_to be_valid
  end

  it 'is not valid with a non-integer cooking time' do
    subject.cooking_time = 'abc'
    expect(subject).not_to be_valid
  end

end
