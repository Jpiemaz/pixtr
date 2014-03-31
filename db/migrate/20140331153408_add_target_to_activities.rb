class AddTargetToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :actor_id, :integer, index: true
    add_reference :activities, :target, polymorphic: true, index: true
  end
end
