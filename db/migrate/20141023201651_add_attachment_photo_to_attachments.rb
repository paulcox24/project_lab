class AddAttachmentPhotoToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :attachments, :photo
  end
end
