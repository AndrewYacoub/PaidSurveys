class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :target_group, :string
    add_column :products, :about_publisher, :string
    add_column :products, :price, :decimal
  end
end
