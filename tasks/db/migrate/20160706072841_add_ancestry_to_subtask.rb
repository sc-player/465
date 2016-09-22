class AddAncestryToSubtask < ActiveRecord::Migration
  def change
    add_column :subtasks, :parent_id, :integer
  end
end
