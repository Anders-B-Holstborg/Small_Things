class Category < ApplicationRecord
  has_many :activities
  has_many :category_users
end
