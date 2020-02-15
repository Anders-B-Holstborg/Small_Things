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
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_one_attached :photo
  has_many :activities
  has_many :bookings

  has_many :user_categories
  has_many :categories, through: :user_categories
  has_many :reviews
  has_many :bookings

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
