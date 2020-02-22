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
  end

  def find_user_bookings
    @user_bookings = []
    current_user.bookings.each do |booking|
        if booking.status == 'accepted'
          @user_bookings << booking
        end
      end
    @user_bookings.sort!.reverse!
  end
end
