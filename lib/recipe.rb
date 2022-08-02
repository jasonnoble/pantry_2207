class Recipe
  attr_reader :name, :ingredients_required

  def initialize(recipe_name)
    @name = recipe_name
    @ingredients_required = Hash.new { |hash, ingredient| hash[ingredient] = 0 }
  end

  def add_ingredient(ingredient, quantity)
    @ingredients_required[ingredient] += quantity
  end

  def ingredients
    ingredients_required.keys
  end
end
