class AddAttachmentFileToJobsmedia < ActiveRecord::Migration[6.0]
  def self.up
    change_table :jobsmedia do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :jobsmedia, :file
  end
end
