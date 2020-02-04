class AddTimePreferencesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :time_of_sending, :datetime
    add_column :users, :prefered_day, :datetime
  end
end
