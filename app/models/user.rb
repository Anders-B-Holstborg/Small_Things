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
    UserMailer.with({user: self, activity_one: @user_activity_one, activity_two: @user_activity_two, booking_one: @booking_one, booking_two: @booking_two}).offer_activities.deliver_now
  end

  def offer_activity
    found_category = find_category(@user_categories)

    find_activity(found_category)
  end

  def find_category(categories)
    rolled_category = categories.sample
    rolled_category = rolled_category.category
    if @activity_one
      while rolled_category == @activity_one.category
        rolled_category = categories.sample
        rolled_category = rolled_category.category
      end
    end
    return rolled_category
  end

  def find_activity(category)
    offered_activity = category.activities.sample
    while check_activity_validity(offered_activity)
      category = find_category(@user_categories)
      offered_activity = category.activities.sample
    end
    return offered_activity
  end

  def check_activity_validity(activity)
    self.bookings.find_by(activity_id: activity.id).present?
  end

  def all_activities_offered?(category)
    offered_category_activities_amount = 0
    self.bookings each do |booking|
      offered_category_activities_amount += 1 if booking.activity.category.id == category.id
    end
    category.activities.count == offered_category_activities_amount
  end

  def create_booking(activity)
    @user = self
    @booking = Booking.find_by(user_id: @user.id, activity_id: activity.id)
    unless @booking
      @booking = Booking.new(user_id: @user.id, activity_id: activity.id)
      @booking.offered
      @booking.save!
    end
    return @booking
  end
end
