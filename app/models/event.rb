class Event < ApplicationRecord
    belongs_to :user
    has_attached_file :featured_image, 
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
    validates_attachment :featured_image, presence: true
    do_not_validate_attachment_file_type :featured_image
    # before_update :set_slug
    # before_create :set_slug
    
    # This method tells us if the user is an blogger or not.
    def is_blogger?
        role == 'blogger'
    end
    # def to_slug(title)
    #     title.strip.downcase.gsub(/[\s\.\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-_]{2,}/, '-').gsub(/^[-_]/, '').gsub(/[-_]$/, '')
    # end

    # def set_slug
    #     self.update_attribute(:slug, to_slug(self.title))
    # end

end
