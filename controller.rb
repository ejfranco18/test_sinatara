require_relative "view"
require_relative "recipe"
require_relative "scraper"

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.display(@cookbook.all)
  end

  def create
    recipe = @view.ask_for_recipe
    description = @view.ask_for_recipe_description
    prep_time = @view.ask_for_recipe_prep_time
    ingredients = @view.ask_for_ingredients
    new_recipe = Recipe.new(recipe, description, prep_time, ingredients, false)
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    @view.display(@cookbook.all)
    index = @view.ask_for_index
    @cookbook.remove_recipe(index)
  end

  def modify
    @view.display(@cookbook.all)
    index = @view.ask_for_index
    new_recipe_name = @view.ask_for_recipe
    new_recipe_description = @view.ask_for_recipe_description
    new_recipe_prep_time = @view.ask_for_recipe_description
    new_recipe_ingredients = @view.ask_for_ingedients
    @cookbook.modify_recipe(index, new_recipe_name, new_recipe_description, new_recipe_prep_time, new_recipe_ingredients, false)
    @view.display(@cookbook.all)
  end

  def import
    @ingredient = @view.ask_for_ingredient
    puts "Looking for #{@ingredient} on LetsCookFrench..."
    scraper = Scraper.new(@ingredient)
    results = @view.display_results(scraper.recipes_titles)
    index = @view.ask_for_recipe_import - 1
    scraper.take_recipe(results[index].values.first)
    new_recipe = Recipe.new(scraper.title, scraper.description, scraper.prep_time, scraper.ingredients)
    @cookbook.add_recipe(new_recipe)
  end

  def mark
    @view.display_mark(@cookbook.all)
    @cookbook.mark_recipe(@view.ask_for_index_mark)
  end
end
