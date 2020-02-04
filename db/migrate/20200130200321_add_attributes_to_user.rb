class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :time_of_sending, :datetime
    add_column :users, :preferred_day, :datetime
  end
end
