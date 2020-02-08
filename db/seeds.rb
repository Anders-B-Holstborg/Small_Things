require 'faker'

date_time_parse = ["2020-02-04 18:25:00", "2020-02-04 18:00:00", "2020-02-04 20:40:00", "2020-02-04 08:35:00", "2020-02-04 12:12:00", "2020-02-04 00:00:00", "2020-02-04 16:50:00"]

User.create!(name: "admin", email: "admin@admin.admin", time_of_sending: Date.parse(date_time_parse.sample), password: "123456", password_confirmation: '123456')
puts "Admin added!"

puts "Creating users..."
10.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, time_of_sending: Date.parse(date_time_parse.sample), password: "123456", password_confirmation: '123456')
end
puts "#{User.count - 1} users added!"

#  Lifestyle Culture Human-Contact Family Learning
category_titles = %w[Reading Sports Culture]

activities = {
  Reading: [
    { title: "Newspaper", description: "Read a newspaper of your choice today", duration: 15 },
    { title: "Book", description: "Read a chapter of an ongoing book today", duration: 20 },
    { title: "Blog", description: "Read one entry in a blog of your choice", duration: 15 }
  ],
  Sports: [
    { title: "Run", description: "Go for a quick run in the vicinity", duration: 15 },
    { title: "Bike Ride", description: "Take a bike ride through the local area or an area of your choice", duration: 15 },
    { title: "Pushups", description: "2-3 sessions of 5-10 pushups", duration: 10 }
  ],
  Culture: [
    { title: "Theatre", description: "A few theatres nearby are doing shows. Time to see one of them!", duration: 120 },
    { title: "Arts Exhibition", description: "There is a gallery nearby. Give it a check-out!", duration: 60 },
    { title: "Comics", description: "Read a classic comic of your choice", duration: 30 }
  ]
}

puts "Creating categories..."
@added_cats = 0
category_titles.each do |title|
  @category = Category.create(title: title) if Category.where(title: title).empty?
  @added_cats += 1 if @category
end
puts "#{@added_cats} categories added!"

puts "Adding activities..."
@added_acts = 0
activities.each do |key, value|
  @category = Category.find_by(title: key)
  value.each do |activity_args|
    activity_args = activity_args.merge(category_id: @category.id)
    @acts = Activity.create(activity_args)
    @added_acts += 1
  end
end

puts "We did it fam. Added #{@added_acts} activities!"
puts "End of the line!"
