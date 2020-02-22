class User < ApplicationRecord
  # after_create :send_welcome_email

  ALLOWED_DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :time_of_sending, presence: true
  # validates :preferred_day, presence: true
  #geocoded_by :address
  #after_validation :geocode, if: :will_save_change_to_city?
  has_one_attached :photo
  has_many :activities
  has_many :bookings

  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :reviews
  has_many :bookings

#  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def send_activity_email
    @user_categories = self.user_categories.where(user_category_preference: true).to_a
    @user_activity_one = offer_activity
    @user_activity_two = offer_activity
    @booking_one = create_booking(@user_activity_one)
    @booking_two = create_booking(@user_activity_two)
    UserMailer.with(
      {user: self, activity_one: @user_activity_one, activity_two: @user_activity_two, booking_one: @booking_one, booking_two: @booking_two}
    ).offer_activities.deliver_now
  end

  def offer_activity
    found_category = find_category(@user_categories)
    find_activity(found_category)
  end

  def find_category(categories)
    rolled_categories = categories.sample
    rolled_category = rolled_categories.category
    if @activity_one
      while rolled_category == @activity_one.category
        rolled_categories = categories.sample
        rolled_category = rolled_categories.category
      end
    end
    return rolled_category
  end

  def find_activity(category)
    rolled_activity = category.activities.sample
    unless activity_offerable?(category, rolled_activity)
      rolled_activity = category.activities.sample
    end
    return rolled_activity
  end

  def activity_offerable?(category, activity)
    @user_bookings = self.bookings.where(activity: category.activities)
    activities_hash = Hash.new(0)
    @user_bookings.each do |booking|
      activity = booking.activity
      activities_hash[activity] += 1
    end
    highest_offered_amount = activities_hash.max_by {|_k,v| v}[1]
    lowest_offered_amount = activities_hash.min_by {|_k,v| v}[1]
    lowest_offered_amount != highest_offered_amount ? activities_hash[activity] == highest_offered_amount : true
  end

  def create_booking(activity)
    @booking = Booking.new(user_id: self.id, activity_id: activity.id)
    @booking.offered
    @booking.save!
    return @booking
  end
end
