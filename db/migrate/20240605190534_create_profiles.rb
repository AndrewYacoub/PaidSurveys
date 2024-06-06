class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :age
      t.string :gender
      t.string :occupation
      t.string :education

      t.timestamps
    end
  end
end
