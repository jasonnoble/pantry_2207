require 'spec_helper'
require './lib/pantry'
require './lib/ingredient'

RSpec.describe Pantry do
  let(:pantry) { described_class.new }
  let(:ingredient1) { Ingredient.new({ name: "Cheese", unit: "C", calories: 100 }) }
  let(:ingredient2) { Ingredient.new({ name: "Macaroni", unit: "oz", calories: 30 }) }
  let(:recipe1) {
    recipe = Recipe.new("Mac and Cheese")
    recipe.add_ingredient(ingredient1, 2)
    recipe.add_ingredient(ingredient2, 8)
    recipe
  }

  describe '#new' do
    it 'is a Pantry' do
      expect(pantry).to be_a(described_class)
    end
  end

  describe '#stock' do
    it 'is empty by default' do
      expect(pantry.stock).to eq({})
    end
  end

  describe '#stock_check(ingredient1)' do
    context 'when the ingredient is out of stock' do
      it 'provides the unit count for the pantry' do
        expect(pantry.stock_check(ingredient1)).to eq(0)
      end
    end
  end

  describe '#restock(ingredient1, 5)' do
    it 'changes the unit count for the ingredient' do
      expect { pantry.restock(ingredient1, 5) }.to change { pantry.stock_check(ingredient1) }.from(0).to(5)
    end
  end

  describe '#enough_ingredients_for?(recipe)' do
    it 'returns false when we need to go shopping' do
      pantry.restock(ingredient1, 5)
      pantry.restock(ingredient1, 10)
      expect(pantry.enough_ingredients_for?(recipe1)).to be(false)
    end

    it 'returns true when we have all the required ingredients' do
      pantry.restock(ingredient1, 5)
      pantry.restock(ingredient1, 10)
      pantry.restock(ingredient2, 8)
      expect(pantry.enough_ingredients_for?(recipe1)).to be(true)
    end
  end
end
