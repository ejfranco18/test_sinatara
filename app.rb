require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'scraper'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

cookbook = Cookbook.new('recipes.csv')


get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/recipes/:name' do
  @recipe = cookbook.all.select do |recipe|
    recipe.name == params[:name]
  end.first
  erb :recipe
end

get '/form' do
  erb :form
end

post '/new_recipe' do
  name = params[:recipe_name]
  description = params[:recipe_description]
  prep_time = params[:recipe_prep_time]
  ingredients = params[:ingredients]
  new_recipe = Recipe.new(name, description, prep_time, ingredients, false)
  cookbook.add_recipe(new_recipe)
  redirect to '/'
end

get '/remove' do
  @recipes = cookbook.all
  erb :remove
end

post '/remove_recipe' do
  index = params[:recipe_index].to_i
  cookbook.remove_recipe(index - 1)
  redirect to '/'
end

get '/import' do
  erb :import
end

get '/select_recipe' do
  ingredient
  erb :select_recipe
end

post '/select_ingredient' do
  @ingredient = params[:ingredient]
  # "My ingredient is #{@ingredient}"
  # @scrape = Scraper.new(ingredient)
  # @scrape
  # redirect to '/select_recipe'
  erb :select_recipe
end


