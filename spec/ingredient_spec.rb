require 'spec_helper'
require './lib/ingredient'

RSpec.describe Ingredient do
  let(:ingredient) { Ingredient.new({ name: "Cheese", unit: "oz", calories: 50 })}

  describe '#new(attributes)' do
    it 'is a Ingredient' do
      expect(ingredient).to be_a(described_class)
    end
  end

  describe '#name' do
    it 'provides the name of the ingredient' do
      expect(ingredient.name).to eq("Cheese")
    end
  end
  describe '#unit' do
    it 'provides the unit of the ingredient' do
      expect(ingredient.unit).to eq("oz")
    end
  end
  describe '#calories' do
    it 'provides the calories of the ingredient' do
      expect(ingredient.calories).to eq(50)
    end
  end
end
