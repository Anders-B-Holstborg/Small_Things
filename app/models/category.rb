class Category < ApplicationRecord
  has_many :activities
  has_many :user_categories
  has_one_attached :photo
end
