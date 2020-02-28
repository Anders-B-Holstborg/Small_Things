require 'json'
require 'open-uri'
require 'open_weather'
class UsersController < ApplicationController
  def index
    @users = User.where.not(latitude: nil, longitude: nil)
  end

  def dashboard
    if !current_user
      redirect_to new_user_registration_path
    else
      @user_accepted_bookings = find_user_bookings
      @user_approved_activities = current_user.activities.where(status: 'approved')
      @total_user_activities_completed = user_activities_completed
      url = 'https://quote-garden.herokuapp.com/quotes/random'
      user_serialized = open(url).read
      quote = JSON.parse(user_serialized)
      @quote = quote["quoteText"]
      @quote_author = quote["quoteAuthor"]
    end
  end

  def find_user_bookings
    @user_bookings = []
    current_user.bookings.each do |booking|
      @user_bookings << booking if booking.status == 'accepted' || booking.status == 'completed'
    end
    @user_bookings.sort!.reverse!
  end

  def user_activities_completed
    all_user_created_activities = 0
    total_activities = 0
    @user_approved_activities.each do |activity|
      all_user_created_activities = Booking.where(activity_id: activity.id)
      total_activities += all_user_created_activities.count
    end
    return total_activities
  end
end
