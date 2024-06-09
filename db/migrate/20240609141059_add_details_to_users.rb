class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age, :integer
    add_column :users, :gender, :string
    add_column :users, :occupation, :string
    add_column :users, :education, :string
  end
end
