class BankAccount < ApplicationRecord
  belongs_to :user
  validates :bank_name, :account_number, presence: true
end
