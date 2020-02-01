class CategoryUser < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :user_category_preference, presence: true
  validates :time_length_preference, numericality: { greater_than_or_equal_to: 0 }

  private

  def increase_counter
    self.offered_counter += 1
  end
end
