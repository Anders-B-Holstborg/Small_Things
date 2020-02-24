class AddStatusToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :activity, :string
  end
end
