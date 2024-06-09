# app/models/wallet.rb
class Wallet < ApplicationRecord
  belongs_to :user
  
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def deposit(amount)
    self.balance += amount
    save!
  end

  def withdraw(amount)
    self.balance -= amount
    save!
  end
end
