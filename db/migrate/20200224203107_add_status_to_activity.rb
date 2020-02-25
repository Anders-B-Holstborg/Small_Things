class AddStatusToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :status, :string
  end
end
