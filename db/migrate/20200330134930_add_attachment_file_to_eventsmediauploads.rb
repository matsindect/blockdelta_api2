class AddAttachmentFileToEventsmediauploads < ActiveRecord::Migration[6.0]
  def self.up
    change_table :eventsmediauploads do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :eventsmediauploads, :file
  end
end
