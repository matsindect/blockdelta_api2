class AddAttachmentFileToBlogsmediauploads < ActiveRecord::Migration[6.0]
  def self.up
    change_table :blogsmediauploads do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :blogsmediauploads, :file
  end
end
