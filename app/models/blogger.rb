class Blogger < ApplicationRecord
    include Filterable
    scope :filter_by_user_id, -> (user_id) { where user_id: user_id }
    belongs_to :user
    before_save :set_slug
    after_save :update_blogs
    has_attached_file :profile_pic, 
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:id/:attachment/:style/:basename.:extension',
                    :url => '/:class/:id/:attachment/:basename.:extension' 
    validates_attachment :profile_pic, presence: true
    do_not_validate_attachment_file_type :profile_pic
    # background picture
    has_attached_file :background_pic, 
                    :styles => { :thumb => "75x75>", :small => "1920x1080>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:id/:attachment/:style/:basename.:extension',
                    :url => '/:class/:id/:attachment/:basename.:extension'
    validates_attachment :background_pic, presence: true
    do_not_validate_attachment_file_type :background_pic

    def update_blogs
        @blogger = Blogger.find_by(:user_id => self.user_id)
        Blog.where(:user_id => @blogger.user_id).update_all(author_slug: @blogger.slug)
    end
    def set_slug
        self.slug = "#{first_name.to_s.parameterize}-#{surname.to_s.parameterize}-#{user_id.to_s}"
        
    end 
    def can_modify_blogger?(user_id)
        role == 'admin' || role == 'blogger' &&  id.to_s == user_id.to_s
    end
    # This method tells us if the user is an blogger or not.
    def is_blogger?
        role == 'blogger'
    end
end
