class AddibanAndswiftCodeToBankAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :bank_accounts, :iban, :string
    add_column :bank_accounts, :swift_code, :string
  end
end
