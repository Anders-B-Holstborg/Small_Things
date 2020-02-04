require 'faker'

date_time_parse = ["2020-02-04 18:25:00", "2020-02-04 18:00:00", "2020-02-04 20:40:00", "2020-02-04 08:35:00", "2020-02-04 12:12:00", "2020-02-04 00:00:00", "2020-02-04 16:50:00"]

puts "Creating users..."
10.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, time_of_sending: Date.parse(date_time_parse.sample), password: "123456", password_confirmation: '123456')
end
puts "#{User.count} users added!"

category_titles = %w["Reading", "Sports", "Lifestyle", "Culture", "Human Contact", "Family"]

puts "Creating categories..."
category_titles.each do |title|
  Category.create(title: title)
end
puts "#{category_titles.count} categories added!"
