class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :survey

  validates :amount, presence: true
  validates :payment_method, presence: true
end
