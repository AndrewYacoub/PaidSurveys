class RemoveAboutPublisherAndTargetGroupFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :about_publisher, :text
    remove_column :products, :target_group, :text
  end
end
