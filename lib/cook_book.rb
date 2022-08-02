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

  def highest_calorie_meal
    recipes.max_by{|recipe| recipe.total_calories }
  end
end
