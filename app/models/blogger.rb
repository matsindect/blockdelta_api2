class Blogger < ApplicationRecord
    include Filterable
    scope :filter_by_user_id, -> (user_id) { where user_id: user_id }
    belongs_to :user
    belongs_to :profile
    has_many :blogs, dependent: :destroy
    has_many :events, dependent: :destroy
    has_attached_file :profile_pic, 
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension' 
    validates_attachment :profile_pic, presence: true
    do_not_validate_attachment_file_type :profile_pic
    # background picture
    has_attached_file :background_pic, 
                    :styles => { :thumb => "75x75>", :small => "1920x1080>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
    validates_attachment :background_pic, presence: true
    do_not_validate_attachment_file_type :background_pic

    
    def set_slug
        self.slug = job_title.to_s.parameterize
    end 
    def can_modify_blogger?(user_id)
        role == 'admin' || role == 'blogger' &&  id.to_s == user_id.to_s
    end
    # This method tells us if the user is an blogger or not.
    def is_blogger?
        role == 'blogger'
    end
end
