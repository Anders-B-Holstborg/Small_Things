class AddDateCompletedToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :date_of_completion, :datetime
  end
end
