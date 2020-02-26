class Event < ApplicationRecord
    belongs_to :user
    has_attached_file :featured_image, 
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
    validates_attachment :featured_image, presence: true
    do_not_validate_attachment_file_type :featured_image

    
    # This method tells us if the user is an blogger or not.
    def is_blogger?
        role == 'blogger'
    end
end
