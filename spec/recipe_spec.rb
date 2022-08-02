require 'spec_helper'
require './lib/recipe'
require './lib/ingredient'

RSpec.describe Recipe do
  let(:ingredient1) { Ingredient.new({ name: "Cheese", unit: "C", calories: 100 }) }
  let(:ingredient2) { Ingredient.new({ name: "Macaroni", unit: "oz", calories: 30 }) }
  let(:ingredient3) { Ingredient.new({ name: "Ground Beef", unit: "oz", calories: 100 }) }
  let(:ingredient4) { Ingredient.new({ name: "Bun", unit: "g", calories: 75 }) }
  let(:recipe1) { described_class.new("Mac and Cheese") }
  let(:recipe2) { described_class.new("Cheese Burger") }

  describe '#new(recipe_name)' do
    it 'is a Recipe' do
      expect(recipe1).to be_a(described_class)
    end
  end

  describe '#name' do
    it "returns the recipe's name" do
      expect(recipe1.name).to eq("Mac and Cheese")
    end
  end

  describe '#ingredients_required' do
    context 'with no ingredients' do
      it 'returns an empty list' do
        expect(recipe1.ingredients_required).to eq({})
      end
    end
  end

  describe '#add_ingredient(ingredient, quantity)' do
    it 'adds the ingredient to the required ingredients' do
      recipe1.add_ingredient(ingredient1, 2)
      expect(recipe1.ingredients_required[ingredient1]).to eq(2)
    end

    it 'increments the ingredient if already added' do
      recipe1.add_ingredient(ingredient1, 2)
      recipe1.add_ingredient(ingredient1, 4)
      expect(recipe1.ingredients_required[ingredient1]).to eq(6)
    end
  end

  describe '#ingredients' do
    it 'lists the ingredients' do
      recipe1.add_ingredient(ingredient1, 2)
      recipe1.add_ingredient(ingredient2, 2)
      expect(recipe1.ingredients).to eq([ingredient1, ingredient2])
    end
  end

  describe "#total_calories" do
    before do
      recipe1.add_ingredient(ingredient1, 2) # Calories: 2 * 100
      recipe1.add_ingredient(ingredient2, 8) # Calories: 8 * 30

      recipe2.add_ingredient(ingredient1, 2) # Calories: 2 * 100
      recipe2.add_ingredient(ingredient3, 4) # Calories: 4 * 100
      recipe2.add_ingredient(ingredient4, 1) # Calories: 1 * 75
    end

    it "returns the total calories for recipe1" do
      expect(recipe1.total_calories).to eq(440)
    end

    it "returns the total calories for recipe2" do
      expect(recipe2.total_calories).to eq(675)
    end
  end
end
