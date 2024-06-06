class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :wallet_number

      t.timestamps
    end
  end
end
