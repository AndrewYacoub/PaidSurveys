class AddAboutPublisherAndTargetGroupToSurveys < ActiveRecord::Migration[6.0]
  def change
    add_column :surveys, :about_publisher, :text
    add_column :surveys, :target_group, :text
  end
end
