# app/models/question.rb
class Question < ApplicationRecord
  belongs_to :survey
  has_many :responses
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true
end