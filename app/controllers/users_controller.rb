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
      url = 'https://quote-garden.herokuapp.com/quotes/random'
      user_serialized = open(url).read
      quote = JSON.parse(user_serialized)
      @quote = quote["quoteText"]
      @quote_author = quote["quoteAuthor"]
      options = { units: "metric", APPID: "946bfbf42b2767701ba937cb4802fc37" }
      weather = OpenWeather::Current.city_id("2800867", options)
      @weather = weather["weather"]
    end
  end
end
