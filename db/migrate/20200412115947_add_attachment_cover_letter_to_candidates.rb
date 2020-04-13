class AddAttachmentCoverLetterToCandidates < ActiveRecord::Migration[6.0]
  def self.up
    change_table :candidates do |t|
      t.attachment :cover_letter
    end
  end

  def self.down
    remove_attachment :candidates, :cover_letter
  end
end
