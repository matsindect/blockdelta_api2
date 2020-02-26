class AddAttachmentFeaturedImageToBlogs < ActiveRecord::Migration[6.0]
  def self.up
    change_table :blogs do |t|
      t.attachment :featured_image
    end
  end

  def self.down
    remove_attachment :blogs, :featured_image
  end
end
