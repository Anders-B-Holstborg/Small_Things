class Activity < ApplicationRecord
  PENDING_STATUS = %w[pending approved default].freeze
  belongs_to :user, optional: true
  belongs_to :category
  has_many :bookings
  validates :duration, numericality: { greater_than_or_equal_to: 0 }
  has_one_attached :photo
  validates :status, inclusion: { in: PENDING_STATUS }
end
