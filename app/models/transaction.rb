class Transaction < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :category
  belongs_to :user

  validates :amout, presence: true, numericality: { greater_than: 0 }
end
