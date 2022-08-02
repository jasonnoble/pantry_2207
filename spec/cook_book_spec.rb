require 'spec_helper'
require './lib/cook_book'
require './lib/recipe'

RSpec.describe CookBook do
  let(:recipe1) { Recipe.new("Mac and Cheese") }
  let(:recipe2) { Recipe.new("Cheese Burger") }
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
end
