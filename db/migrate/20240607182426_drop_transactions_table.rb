class DropTransactionsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :transactions
  end

  def down
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :survey, null: false, foreign_key: true
      t.decimal :amount
      t.string :payment_method
      t.string :status

      t.timestamps
    end
  end
end
