class Blog < ApplicationRecord
    after_save :set_published_at
    belongs_to :user
    belongs_to :sector
    belongs_to :category
    has_attached_file :featured_image,
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
    validates_attachment :featured_image, presence: true
    do_not_validate_attachment_file_type :featured_image
    # before_update :set_slug
    # before_create :set_slug
    # This method gives us a simple call to check if a user has permission to modify.
    def can_modify_blog?(user_id)
        role == 'admin' || (role == 'blogger' && id.to_s == user_id.to_s)
    end

    def set_published_at 
    self.published_at = DateTime.now if self.published
    end

    # def to_slug(title)
    #     title.strip.downcase.gsub(/[\s\.\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-_]{2,}/, '-').gsub(/^[-_]/, '').gsub(/[-_]$/, '')
    # end

    # def set_slug
    #     self.update_attribute(:slug, to_slug(self.title))
    # end
end
