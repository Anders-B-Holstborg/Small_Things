class Booking < ApplicationRecord
  ALLOWED_STATUSES = %w[offered accepted completed not_completed refused].freeze
  belongs_to :user
  belongs_to :activity
  validates :status, inclusion: { in: ALLOWED_STATUSES }

  def Booking.rating_average(activity)
    bookings = Booking.where(activity_id: activity.id).where(status: 'accepted')
    rating_total = 0
    bookings.each do |booking|
      rating_total += booking.rating
    end
    average_of_total = rating_total / (bookings.count)
  end

  def offered
    self.update!(status: 'offered')
  end

  def accepted
    self.date_of_completion = DateTime.now
    self.rating = 5
    self.status = 'accepted'
    self.save
  end

  def completed
    self.update!(status: 'completed')
  end

  def not_completed
    self.update!(status: 'not_completed')
  end

  def refused
    self.update!(status: 'refused')
  end
end
