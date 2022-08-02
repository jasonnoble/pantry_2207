require 'spec_helper'
require './lib/cook_book'
require './lib/recipe'

RSpec.describe CookBook do
  let(:ingredient1) { Ingredient.new({ name: "Cheese", unit: "C", calories: 100 }) }
  let(:ingredient2) { Ingredient.new({ name: "Macaroni", unit: "oz", calories: 30 }) }
  let(:ingredient3) { Ingredient.new({ name: "Ground Beef", unit: "oz", calories: 100 }) }
  let(:ingredient4) { Ingredient.new({ name: "Bun", unit: "g", calories: 75 }) }
  let(:recipe1) {
    recipe = Recipe.new("Mac and Cheese")
    recipe.add_ingredient(ingredient1, 2)
    recipe.add_ingredient(ingredient2, 8)
    recipe
  }
  let(:recipe2) {
    recipe = Recipe.new("Cheese Burger")
    recipe.add_ingredient(ingredient1, 2)
    recipe.add_ingredient(ingredient3, 4)
    recipe.add_ingredient(ingredient4, 1)
    recipe
  }

  let(:cookbook) { described_class.new }

  describe '#new' do
    it 'creates a CookBook' do
      expect(cookbook).to be_a(described_class)
    end
  end

  describe '#add_recipe(recipe)' do
    it 'adds the recipe to the cookbook' do
      expect { cookbook.add_recipe(recipe1) }.to change(cookbook.recipes, :count).from(0).to(1)
    end
  end

  describe '#ingredients' do
    before do
      cookbook.add_recipe(recipe1)
      cookbook.add_recipe(recipe2)
    end

    it 'returns all the ingredient names for all recipes' do
      expect(cookbook.ingredients).to eq(["Cheese", "Macaroni", "Ground Beef", "Bun"])
    end
  end
end
