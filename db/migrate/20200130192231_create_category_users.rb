class CreateCategoryUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :category_users do |t|
      t.references :user, foreign_key: true
      t.references :category
      t.boolean :user_category_preference
      t.integer :time_length_preference
      t.integer :offered_counter

      t.timestamps
    end
  end
end
