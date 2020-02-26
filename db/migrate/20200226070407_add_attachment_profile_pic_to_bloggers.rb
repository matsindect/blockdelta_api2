class AddAttachmentProfilePicToBloggers < ActiveRecord::Migration[6.0]
  def self.up
    change_table :bloggers do |t|
      t.attachment :profile_pic
    end
  end

  def self.down
    remove_attachment :bloggers, :profile_pic
  end
end
