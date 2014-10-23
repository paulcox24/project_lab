class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :project, index: true
      t.binary :photo

      t.timestamps
    end
  end
end
