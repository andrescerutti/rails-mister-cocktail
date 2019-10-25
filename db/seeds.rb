# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Creating cocktails...'
cocktails_attributes = ['fernet', 'gin tonic', 'aperol sprits', 'mojito', 'piel de higuana', 'campari', 'gancia', 'schweepes', 'cocacola', 'daikiri', ' cinnamon', 'whiskacho']



require 'faker'
require 'open-uri'

url = open('https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list').read
ingredients_array = JSON.parse(url)
puts 'Creating ingredient...'
ingredients_array['drinks'].each do |ingredient|
  new_ingredient = Ingredient.new
  new_ingredient.name = ingredient['strIngredient1']
  new_ingredient.save
end



puts 'Finished!'

cocktails_attributes.each do |name|
  cocktail = Cocktail.create!(
    name: name
    )
  puts "created new cocktail #{cocktail.name}"
  3.times do
  dose = Dose.create(
    cocktail: cocktail,
    ingredient: Ingredient.all.sample,
    description:Faker::Restaurant.description
    )
  puts "created new dose for #{cocktail.name} = #{dose.description} with this ingredient #{dose.ingredient}"
end

end
