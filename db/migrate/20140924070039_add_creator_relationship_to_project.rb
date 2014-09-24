class AddCreatorRelationshipToProject < ActiveRecord::Migration
  def change
    remove_column :projects, :creator, :string
    add_reference :projects, :user

  end
end
