class Pantry
  attr_reader :stock

  def initialize
    @stock = Hash.new { |hash, ingredient| hash[ingredient] = 0 }
  end

  def stock_check(ingredient)
    stock[ingredient]
  end

  def restock(ingredient, count)
    stock[ingredient] += count
  end

  def enough_ingredients_for?(recipe)
    recipe.ingredients_required.map do |ingredient, quantity|
      stock_check(ingredient) >= quantity
    end.all?
  end
end
