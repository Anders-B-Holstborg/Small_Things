class User < ApplicationRecord
  after_create :send_welcome_email, :create_user_categories

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
  has_many :accepted_bookings, -> () { where(status: :accepted) }, class_name: "Booking"
  has_many :accepted_activities, through: :accepted_bookings, source: :activity


  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :reviews

  def send_presentation_email
    @user_activity_one = Activity.find_by(title: "High Fives!")
    @user_activity_two = Activity.find_by(title: "Pushups")
    @booking_one = create_booking(@user_activity_one)
    @booking_two = create_booking(@user_activity_two)
    UserMailer.with(
      {user: self, activity_one: @user_activity_one, activity_two: @user_activity_two, booking_one: @booking_one, booking_two: @booking_two}
    ).offer_activities.deliver_now
  end

#  private <--- turn on when pushing to production for real

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def create_user_categories
    @categories = Category.all
    @categories.each do |category|
      UserCategory.create!(user_id: self.id, category_id: category.id, time_length_preference: 30, user_category_preference: true)
    end
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
    found_category = find_category
    find_activity(found_category)
  end

  def find_category
    rolled_category = @user_categories.sample.category
    if @user_activity_one
      while rolled_category == @user_activity_one.category
        rolled_category = user_categories.sample.category
      end
    end
    return rolled_category
  end

  def find_activity(category)
    rolled_activity = category.activities.where().not(status: 'pending').where().not(status: 'denied').sample
    check_activity_existance = rolled_activity
    while check_activity_existance.nil?
      category = find_category
      rolled_activity = category.activities.where().not(status: 'pending').where().not(status: 'denied').sample
      check_activity_existance = rolled_activity
    end
    while activity_offerable?(category,rolled_activity)
      rolled_activity = category.activities.sample
    end
    return rolled_activity
  end

  def activity_offerable?(category, activity)
    @user_bookings = self.bookings.where(activity: category.activities)
    activities_hash = Hash.new(0)
    @user_bookings.each do |booking|
      activity_by_count = booking.activity.title
      activities_hash[activity_by_count] += 1
    end
    highest_offered_amount = activities_hash.max_by {|_k,v| v}[1] unless activities_hash.empty?
    lowest_offered_amount = activities_hash.min_by {|_k,v| v}[1] unless activities_hash.empty?
    activities_hash[activity] == highest_offered_amount && lowest_offered_amount != highest_offered_amount
  end

  def create_booking(activity)
    @booking = Booking.new(user_id: self.id, activity_id: activity.id)
    @booking.offered
    @booking.save!
    return @booking
  end
end
