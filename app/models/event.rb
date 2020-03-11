class Event < ApplicationRecord
    include Filterable
    scope :filter_by_event_title, -> (event_title) { where("event_title like ?", "#{event_title}%")}
    # scope :filter_by_event_start_date, -> (event_start_date) { where("event_start_date >= ?", "#{event_start_date}%") }
    # scope :filter_by_event_end_date, -> (event_end_date) { where("event_end_date <= ?", "#{event_end_date}%") }
    after_validation :set_slug, only: [:create, :update]
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
    def set_slug
        self.slug = event_title.to_s.parameterize
    end 

end
