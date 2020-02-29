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
      @total_user_activities_completed = user_submitted_activities_completed
      @total_completed_activities = total_completed_activities
      @percentage_completed_activities = percentage_completed_activities
      url = 'https://quote-garden.herokuapp.com/quotes/random'
      user_serialized = open(url).read
      quote = JSON.parse(user_serialized)
      @quote = quote["quoteText"]
      @quote_author = quote["quoteAuthor"]
    end
  end

  def find_user_bookings
    user_bookings = []
    #current_user.bookings.where(status: "accepted").or(current_user.bookings.where(status: "completed"))
    current_user.bookings.each do |booking|
      user_bookings << booking if booking.status == 'accepted' || booking.status == 'completed'
    end
    user_bookings.sort_by(&:date_of_completion).reverse

  end

  def user_submitted_activities_completed
    all_user_created_activities = 0
    total_activities = 0
    @user_approved_activities.each do |activity|
      all_user_created_activities = Booking.where(activity_id: activity.id)
      total_activities += all_user_created_activities.count
    end
    return total_activities
  end

  def total_completed_activities
    Booking.where(user_id: current_user.id).where(status: 'accepted')
  end

  def percentage_completed_activities
    completed = total_completed_activities.count.to_f
    total_offered = Booking.where(user_id: current_user.id).count
    percentage_completed = (completed / (total_offered / 2) * 100)
  end
end
