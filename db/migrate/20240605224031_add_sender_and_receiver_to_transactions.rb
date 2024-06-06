class AddSenderAndReceiverToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :sender_id, :integer
    add_column :transactions, :receiver_id, :integer
  end
end
