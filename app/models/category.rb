class Category < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :category_type, presence: true
end
