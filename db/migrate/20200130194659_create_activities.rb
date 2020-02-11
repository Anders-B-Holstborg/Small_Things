class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.text :title
      t.text :description
      t.integer :duration

      t.timestamps
    end
  end
end
