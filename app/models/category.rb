class Category < ApplicationRecord
    has_many :products
    has_many :surveys, through: :products
end