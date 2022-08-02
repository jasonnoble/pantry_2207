class Pantry
  attr_reader :stock

  def initialize
    @stock = Hash.new{|hash, ingredient| hash[ingredient] = 0}
  end

  def stock_check(ingredient)
    stock[ingredient]
  end

  def restock(ingredient, count)
    stock[ingredient] += count
  end
end
