class AddAttachmentFileToJobsmediauploads < ActiveRecord::Migration[6.0]
  def self.up
    change_table :jobsmediauploads do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :jobsmediauploads, :file
  end
end
