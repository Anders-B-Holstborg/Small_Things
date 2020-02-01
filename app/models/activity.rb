class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :duration, numericality: { greater_than_or_equal_to: 0 }
end
