class Category < ApplicationRecord
  has_many :activities
  has_many :user_categories
end
