class Blogsmedium < ApplicationRecord
    has_many :blogsmediauploads
    attr_accessor :file

    def save_attachments(params)
        params[:file].each do |image|
          self.blogsmediauploads.create(:file => image)
        end
    end
end
