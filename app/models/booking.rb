class Booking < ApplicationRecord
  ALLOWED_STATUSES = %w[completed offered].freeze
  belongs_to :user
  belongs_to :activity
  has_many :reviews, dependent: :destroy
  validates :status, presence: true, inclusion: { in: ALLOWED_STATUSES }

  def completed!
    self.update!(status: 'completed')
  end

  def offered!
    self.update!(status: 'offered')
  end
end
