class Candidate < ApplicationRecord
    belongs_to :user
    has_attached_file :profile_pic,
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
    validates_attachment :profile_pic, presence: true
    do_not_validate_attachment_file_type :profile_pic

    
end
