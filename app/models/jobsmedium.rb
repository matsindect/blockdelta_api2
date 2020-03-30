class Jobsmedium < ApplicationRecord
    has_many :jobsmediauploads
    attr_accessor :file
    def save_attachments(params)
        params[:file].each do |image|
          self.jobsmediauploads.create(:file => image)
        end
    end
end
