class Candidate < ApplicationRecord
    include Filterable
    scope :filter_by_user_id, -> (user_id) { where user_id: user_id }
    belongs_to :user
    has_attached_file :profile_pic,
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:id/:attachment/:style/:basename.:extension',
                    :url => '/:class/:id/:attachment/:basename.:extension'
    validates_attachment :profile_pic, presence: true
    do_not_validate_attachment_file_type :profile_pic
    has_attached_file :cover_letter, 
                      :path => 
                      ':rails_root/non-public/system/:class/:id/:attachment/:basename.:extension',
                      :url => '/:class/:id/:attachment/:basename.:extension'
    validates_attachment :cover_letter, presence: true
    do_not_validate_attachment_file_type :cover_letter
    has_attached_file :resume, 
                      :path => 
                      ':rails_root/non-public/system/:class/:id/:attachment/:basename.:extension',
                      :url => '/:class/:id/:attachment/:basename.:extension'
    validates_attachment :resume, presence: true
    do_not_validate_attachment_file_type :resume
    
end
