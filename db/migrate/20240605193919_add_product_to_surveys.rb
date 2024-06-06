class AddProductToSurveys < ActiveRecord::Migration[6.0]
  def change
    add_reference :surveys, :product, null: false, foreign_key: true
  end
end
