class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category
  #validates :time_length_preference, presence: false

  private

  def increase_counter
    self.offered_counter += 1
  end
end
