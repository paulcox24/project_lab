class AddCreatorRelationshipToTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :creator, :string
    add_column :tasks, :creator_id, :integer
  end
end
