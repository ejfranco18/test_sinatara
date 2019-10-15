require 'csv'
require_relative 'recipe'

class Cookbook
  # def initialize
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def modify_recipe(recipe_index, new_name, new_desc)
    @recipes[recipe_index].name = new_name
    @recipes[recipe_index].description = new_desc
  end

  def load_csv
    CSV.foreach(@csv_file_path) do |row|
      new_recipe = Recipe.new(row[0], row[1], row[2], row[3], row[4])
      @recipes << new_recipe
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.ingredients, recipe.done]
      end
    end
  end

  def mark_recipe(index)
    @recipes[index].done = "true"
    save_csv
  end
end
