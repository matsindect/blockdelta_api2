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
    validates_attachment :cover_letter, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/octet-stream) }
    
    has_attached_file :resume, 
                      :path => 
                      ':rails_root/non-public/system/:class/:id/:attachment/:basename.:extension',
                      :url => '/:class/:id/:attachment/:basename.:extension'
    validates_attachment :resume, :content_type => { :content_type => %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document application/octet-stream) }
    
    
end
