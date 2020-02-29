date_time_parse = ["2020-02-04 18:25:00", "2020-02-04 18:00:00", "2020-02-04 20:40:00", "2020-02-04 08:35:00", "2020-02-04 12:12:00",
 "2020-02-04 00:00:00", "2020-02-04 16:50:00"]


admin = User.create!(name: "admin", email: "admin@admin.admin", city: "Gotham City", time_of_sending: Date.parse(date_time_parse.sample), password: "123456",
 password_confirmation: '123456', admin: true)

puts "Admin added!"

puts "Creating victim..."
1.times do
  user = User.create!(name: "Captain Bruno", email: "Brudurbecq@gmail.com", city: "Brussels",
    time_of_sending: Date.parse(date_time_parse.sample), password: "123456", password_confirmation: '123456', admin: false)
end
puts "#{User.count - 1} users added!"

# Family Learning
category_titles = %w[Custom Reading Sports Culture Lifestyle Human]

activities = {
  Reading: [
    { title: "Newspaper", description: "Read a newspaper of your choice today", duration: 15 },
    { title: "Book", description: "Read a chapter of an ongoing book today", duration: 20 },
    { title: "Blog", description: "Read one entry in a blog of your choice", duration: 15 }
  ],
  Sports: [
    { title: "Pushups", description: "Do 1-3 sessions of 5-10 pushups, depending on your level.", duration: 10 },
    { title: "Run", description: "Go for a quick run in the vicinity.", duration: 15 },
    { title: "Bike Ride", description: "Take a bike ride through the local area or an area of your choice.", duration: 15 },
    { title: "Sit-Ups", description: "Do 1-3 sessions of 10-20 sit-ups, depending on your level.", duration: 15 }
  ],
  Culture: [
    { title: "Theatre", description: "A few theatres nearby are doing shows. Time to see one of them!", duration: 120 },
    { title: "Arts Exhibition", description: "There is a gallery nearby. Give it a check-out!", duration: 60 },
    { title: "Comics", description: "Read a classic comic of your choice.", duration: 30 }
  ],
  Lifestyle: [
    { title: "Meditation", description: "Find a calm and floofy spot to sit down and attempt to clear your mind for half an hour.", duration: 30 },
    { title: "Niche Cooking", description: "Whip up a healthy dish that you've been wanting to do for a while.", duration: 60 },
    { title: "Rearrange the Home", description: "Think about something in your home that you would like to change, and do it!", duration: 30 },
    { title: "Befriend a Critter", description: "Find an animal of any kind in your vicinity, and make friends with it.", duration: 30 }
  ],
  Human: [
    { title: "High Fives!", description: "Find at least 3 strangers, and offer them a solid high-five!", duration: 60 },
    { title: "Board Game", description: "Invite one or more mates of yours to a few rounds of a board game of your choice.", duration: 60 },
    { title: "Call Relative", description: "Call a relative you have not had contact with in a while.", duration: 20 },
    { title: "Contact a Stranger", description: "Conduct a conversation with someone you have never met or talked to before", duration: 5 },
    { title: "Fight Club Homework", description: "I want you to go out there. I want you to get into a fight with a stranger. And I want you to lose.", duration: 30 }
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
added_acts = 0
activities.each do |key, value|
  @category = Category.find_by(title: key)
  value.each do |activity_args|
    activity_args = activity_args.merge(category_id: @category.id, status: 'default')
    @acts = Activity.create(activity_args)
    added_acts += 1
  end
end

puts "We did it fam. Added #{added_acts} activities!"

puts "Adding user category preferences..."
@users = User.all
@categories = Category.all

@users.each do |user|
  @categories.each do |category|
    time = rand(10..120)
    UserCategory.create!(user_id: user.id, category_id: category.id, time_length_preference: time, user_category_preference: true)
  end
end
puts "Preferences added!"

puts "Adding completed activities to Bruno..."
activities_completed = 0
User.where(name: "Captain Bruno").each do |user|
  time = DateTime.now
  40.times do
    activity = Activity.all.sample
    rating = rand(2..5)
    booking = Booking.create!(user_id: user.id, activity_id: activity.id, status: "accepted", date_of_completion: time, rating: rating)
    activity = Activity.all.sample
    Booking.create!(user_id: user.id, activity_id: activity.id, status: "refused")
    time -= 1
    activities_completed += 1
  end
end
puts "Success! #{activities_completed} completed for the Captain!"

puts "End of the line!"
