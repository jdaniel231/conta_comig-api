class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :category
  belongs_to :user

  validates :amout, presence: true, numericality: { greater_than: 0 }
end
