class Blog < ApplicationRecord
    include Filterable
    scope :filter_by_user_id, -> (user_id) { where user_id: user_id }
    scope :filter_by_sector_id, -> (sector_id) { where sector_id: sector_id }
    scope :filter_by_title, -> (title) { where("title like ?", "#{title}%")}
    before_save :set_slug
    after_validation :set_published_at, only: [:create, :update]
    belongs_to :user
    belongs_to :sector
    has_attached_file :featured_image,
                    :styles => { :thumb => "75x75>", :small => "150x150>" },
                    :path => 
                    ':rails_root/non-public/system/:class/:attachment/:id/:style/:basename.:extension',
                    :url => '/:class/:id/:basename.:extension'
    validates_attachment :featured_image, presence: true
    do_not_validate_attachment_file_type :featured_image
   
    def set_published_at 
    self.published_at = DateTime.now if self.published
    end

    def set_slug
        self.slug = "#{id}-#{title.to_s.parameterize}"
    end 
    
    
end
