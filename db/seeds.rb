puts "Creating users..."
User.create(name: 'dethstriker666', email: "timmy@gmail.com", time_of_sending: Date.parse("2020-02-04 18:25:00"), password: "123456", password_confirmation: '123456')
User.create(name: 'Sammy G', email: "sammy.g@gmail.com", time_of_sending: Date.parse("2020-02-04 15:00:00"), password: "123456", password_confirmation: '123456')
User.create(name: 'Emily Watford', email: "emilyw@atford.com", time_of_sending: Date.parse("2020-02-04 08:00:00"), password: "123456", password_confirmation: '123456')
User.create(name: 'TheExpendableWombat', email: "wombat@gmail.au", time_of_sending: Date.parse("2020-02-04 20:40:00"), password: "123456", password_confirmation: '123456')
User.create(name: 'Bill', email: "bill.hendricks@gloustershire.uk", time_of_sending: Date.parse("2020-02-04 12:00:00"), password: "123456", password_confirmation: '123456')
puts "#{User.count} users added!"
category_titles = %w["Reading", "Sports", "Lifestyle", "Culture", "Human Contact"]
puts "Creating categories..."
category_titles.each do |title|
  Category.create(title: title)
end

puts "#{category_titles.count} categories added!"
