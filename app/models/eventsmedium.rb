class Eventsmedium < ApplicationRecord
    include Filterable
    scope :filter_by_eventsmedium_id, -> (eventsmedium_id) { where eventsmedium_id: eventsmedium_id }
    has_many :eventsmediauploads
    attr_accessor :file
    def save_attachments(params)
        params[:file].each do |image|
          self.eventsmediauploads.create(:file => image)
        end
        
    end

end
