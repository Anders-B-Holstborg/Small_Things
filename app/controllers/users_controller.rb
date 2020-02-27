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
      @user = current_user
      @user_accepted_bookings = find_user_bookings
      url = 'https://quote-garden.herokuapp.com/quotes/random'
      user_serialized = open(url).read
      quote = JSON.parse(user_serialized)
      @quote = quote["quoteText"]
      @quote_author = quote["quoteAuthor"]
    end
    @categories_pie_chart = categories_completed
  end

  def find_user_bookings
    @user_bookings = []
    current_user.bookings.each do |booking|
      @user_bookings << booking if booking.status == 'accepted' || booking.status == 'completed'
    end
    @user_bookings.sort!.reverse!
  end

  def categories_completed
    pie_chart_data = Hash.new(0)
    current_user.bookings.each do |booking|
    pie_chart_data[booking.activity.category] += 1
    end
    return pie_chart_data
  end
end
