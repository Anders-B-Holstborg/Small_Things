class RemoveFieldTimeFromTableUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :time_of_sending
    remove_column :users, :preferred_day
  end
end
