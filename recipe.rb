class Recipe
  attr_accessor :name, :description, :prep_time, :ingredients, :done
  def initialize(name, description, prep_time, ingredients, done)
    @name = name
    @description = description
    @prep_time = prep_time
    @ingredients = ingredients
    @done = done
  end
end

