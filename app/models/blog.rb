class Blog < ApplicationRecord
    include Filterable
    scope :filter_by_user_id, -> (user_id) { where user_id: user_id }
    scope :filter_by_sector_id, -> (sector_id) { where sector_id: sector_id }
    scope :filter_by_title, -> (title) { where("title like ?", "#{title}%")}
    after_update :set_published_at
    after_validation :set_slug, :set_published_at, only: [:create, :update]
    belongs_to :user
    belongs_to :sector
    belongs_to :category
    # has_many :documents
    # # attr_accessor :file
    
    has_many :media, dependent: :destroy
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
        Blog.last ? next_id = (Blog.last.id + 1).to_s : next_id = "1" # takes the next number in the sequence
        if slug.blank?
        self.slug = next_id + "-" + title.downcase.strip.gsub(/\s+/, "-")
        end
    end 
end
