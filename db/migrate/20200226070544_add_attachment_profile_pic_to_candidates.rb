class AddAttachmentProfilePicToCandidates < ActiveRecord::Migration[6.0]
  def self.up
    change_table :candidates do |t|
      t.attachment :profile_pic
    end
  end

  def self.down
    remove_attachment :candidates, :profile_pic
  end
end
