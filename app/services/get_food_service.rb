require 'open-uri'

class GetFoodService
  attr_reader :ingredient, :app_id, :app_key, :base_url, :url

  def initialize(meal_type) #breakfast, lunch, dinner, snack
    @app_id = ENV['EDAMAM_APP_ID']
    @app_key = ENV['EDAMAM_APP_KEY']
    @base_url = 'https://api.edamam.com/api/recipes/v2?type=public'
    @url = "#{@base_url}&app_id=#{app_id}&app_key=#{app_key}&mealType=#{meal_type}&random=true"
    # if you want the API to give you random ones, uncomment this line
    # @url =  "#{@base_url}&app_id=#{app_id}&app_key=#{app_key}&mealType=#{meal_type}&random=true"
  end

  def call
    response = JSON.parse(URI.open(@url).read)
    # debugger # you can use this to stop the program and inspect the response
    # iterate over the recipes in the response to create instances of a Food
    # response['hits'].each do....
    response['hits'].each do |recipe_hash|
      # recipe_hash['ingredients'] => array of ingredients
      recipe_hash["recipe"]["ingredients"].each do |ingredient_hash|
        food = Food.create(
          name: ingredient_hash['food'],
          category: ingredient_hash['foodCategory']
        )
        puts "getting image for #{food.name}"
        if ingredient_hash['image']
          file = URI.open(ingredient_hash['image'])
          food.photo.attach(io: file, filename: "#{ingredient_hash['food']}.png", content_type: "image/png")
        end
        food.save
      end
    end
  end
end

# To test it
# GetFoodService.new('breakfast').call
