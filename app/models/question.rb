# app/models/question.rb
class Question < ApplicationRecord
  belongs_to :survey
  has_many :responses
  has_many :choices, dependent: :destroy
end