class CookBook
  attr_reader :recipes

  def initialize
    @recipes = []
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    recipes.flat_map do |recipe|
      recipe.ingredients.map(&:name)
    end.uniq
  end
end
