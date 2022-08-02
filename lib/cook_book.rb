class CookBook
  attr_reader :recipes, :date

  def initialize
    @recipes = []
    @date = Date.today.strftime("%m-%d-%Y")
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

  def summary
    recipes.map do |recipe|
      {
        name: recipe.name,
        details: {
          total_calories: recipe.total_calories,
          ingredients: recipe.ingredients_required.sort_by { |ingredient, quantity| ingredient.calories * quantity }.reverse.map do |ingredient, quantity|
            {
              ingredient: ingredient.name,
              amount: "#{quantity} #{ingredient.unit}",
            }
          end
        }
      }
    end
  end
end
