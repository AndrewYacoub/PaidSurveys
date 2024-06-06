class Survey < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :category
  has_many :questions, inverse_of: :survey, dependent: :destroy

  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: :all_blank
end