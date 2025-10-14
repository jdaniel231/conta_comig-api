class PaymentMethod < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :payment_type, presence: true
end
