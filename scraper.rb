# require 'open-uri'
# require 'rubygems'
# require 'nokogiri'

# class Scraper
#   DOMAIN = 'http://www.letscookfrench.com/'

#   attr_reader :recipes_titles, :title, :description, :prep_time, :ingredients
#   def initialize(ingredient)
#     @ingredient = ingredient
#     @url = DOMAIN + "recipes/find-recipe.aspx?aqt=" + @ingredient
#     html = open(url).read
#     doc = Nokogiri::HTML(html)
#     @recipes_titles = doc.search('.m_titre_resultat a').first(5).map { |recipe| {recipe.text.strip => recipe.attribute('href').value} }
#   end

#   def take_recipe(path)
#     url = DOMAIN + path
#     html = open(url).read
#     doc = Nokogiri::HTML(html)
#     @title = doc.search('h1').text.strip
#     @description = doc.search('.m_content_recette_breadcrumb').text.split("-").first.strip
#     preptime = doc.search('.preptime').first.text.to_i
#     cooktime = doc.search('.cooktime').first.nil? ? 0 : doc.search('.cooktime').first.text.to_i
#     @prep_time = preptime + cooktime
#     @ingredients = doc.search('.m_content_recette_ingredients.m_avec_substitution').text.strip.gsub(/(Ingredients )|(Switch to oz)|(- \d+ oz.*)|( :\r\n\s*)/,"")
#   end
# end

