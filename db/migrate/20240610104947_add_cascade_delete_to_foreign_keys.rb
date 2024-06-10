class AddCascadeDeleteToForeignKeys < ActiveRecord::Migration[6.0]
  def change
    # Remove existing foreign keys
    remove_foreign_key :questions, :surveys
    remove_foreign_key :choices, :questions
    remove_foreign_key :responses, :surveys

    # Add new foreign keys with ON DELETE CASCADE
    add_foreign_key :questions, :surveys, on_delete: :cascade
    add_foreign_key :choices, :questions, on_delete: :cascade
    add_foreign_key :responses, :surveys, on_delete: :cascade
  end
end
