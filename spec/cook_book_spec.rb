require 'spec_helper'
require 'timecop'
require './lib/cook_book'
require './lib/recipe'

RSpec.describe CookBook do
  let(:ingredient1) { Ingredient.new({ name: "Cheese", unit: "C", calories: 100 }) }
  let(:ingredient2) { Ingredient.new({ name: "Macaroni", unit: "oz", calories: 30 }) }
  let(:ingredient3) { Ingredient.new({ name: "Ground Beef", unit: "oz", calories: 100 }) }
  let(:ingredient4) { Ingredient.new({ name: "Bun", unit: "g", calories: 1 }) }
  let(:recipe1) {
    recipe = Recipe.new("Mac and Cheese")
    recipe.add_ingredient(ingredient1, 2)
    recipe.add_ingredient(ingredient2, 8)
    recipe
  }
  let(:recipe2) {
    recipe = Recipe.new("Burger")
    recipe.add_ingredient(ingredient3, 4)
    recipe.add_ingredient(ingredient4, 100)
    recipe
  }

  let(:cookbook) { described_class.new }

  describe '#new' do
    it 'creates a CookBook' do
      expect(cookbook).to be_a(described_class)
    end
  end

  describe '#date' do
    it 'remembers when it was created' do
      old_cookbook = nil
      Timecop.travel(Time.local(2020, 4, 22, 12, 0, 0)) do
        old_cookbook = described_class.new
      end
      expect(old_cookbook.date).to eq("04-22-2020")
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

  describe '#highest_calorie_meal' do
    before do
      cookbook.add_recipe(recipe1)
      cookbook.add_recipe(recipe2)
    end
    it 'returns the recipe for the highest calorie meal' do
      expect(cookbook.highest_calorie_meal).to eq(recipe2)
    end
  end

  describe '#summary' do
    # List ingredients in order of calories
    before do
      cookbook.add_recipe(recipe1)
      cookbook.add_recipe(recipe2)
    end

    it 'returns a summary of the cookbook' do
      expected = [{ :name => "Mac and Cheese", :details => { :ingredients => [{ :ingredient => "Macaroni", :amount => "8 oz" }, { :ingredient => "Cheese", :amount => "2 C" }], :total_calories => 440 } }, { :name => "Burger", :details => { :ingredients => [{ :ingredient => "Ground Beef", :amount => "4 oz" }, { :ingredient => "Bun", :amount => "100 g" }], :total_calories => 500 } }]
      expect(cookbook.summary).to eq(expected)
    end
  end
end
