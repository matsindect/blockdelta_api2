class AddAttachmentBackgroundPicToBloggers < ActiveRecord::Migration[6.0]
  def self.up
    change_table :bloggers do |t|
      t.attachment :background_pic
    end
  end

  def self.down
    remove_attachment :bloggers, :background_pic
  end
end
