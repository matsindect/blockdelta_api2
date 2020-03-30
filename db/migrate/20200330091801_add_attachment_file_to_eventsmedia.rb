class AddAttachmentFileToEventsmedia < ActiveRecord::Migration[6.0]
  def self.up
    change_table :eventsmedia do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :eventsmedia, :file
  end
end
