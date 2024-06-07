class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile
  has_many :bank_accounts
  has_many :wallets
  has_many :opinions
  has_one :wallet, dependent: :destroy
  has_one :bank_account, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :surveys, through: :responses
  accepts_nested_attributes_for :wallet, allow_destroy: true
  accepts_nested_attributes_for :bank_account, allow_destroy: true

  has_many :sent_transactions, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :received_transactions, class_name: 'Transaction', foreign_key: 'receiver_id'

  after_create :create_wallet

  validates :name, presence: true

  private

  def create_wallet
    Wallet.create(user: self, balance: 0.0)
  end
end
