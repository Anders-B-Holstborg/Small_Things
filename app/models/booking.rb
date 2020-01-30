class Booking < ApplicationRecord
  ALLOWED_STATUSES = %w[completed offered].freeze
  belongs_to :user
  belongs_to :activity
  has_many :reviews
  validates :status, inclusion: { in: ALLOWED_STATUSES }
end
