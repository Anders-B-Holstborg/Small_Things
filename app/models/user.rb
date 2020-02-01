class User < ApplicationRecord
  ALLOWED_DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :time_of_sending, presence: true
  validates :preferred_day, inclusion: { in: ALLOWED_DAYS }
end
