class Job < ApplicationRecord
    include Filterable
    scope :filter_by_sector_id, -> (sector_id) { where sector_id: sector_id }
    scope :filter_by_job_title, -> (job_title) { where("job_title like ?", "#{job_title}%")}
    before_save :set_slug
    belongs_to :sector
    has_many :jobsmedia
    attr_accessor :file
    # has_many :media, dependent: :destroy
    # before_update :set_slug
    # before_create :set_slug
     # This method tells us if the user is an admin or not.

    def save_attachments(params)
        params[:file].each do |image|
          self.jobsmedia.create(:file => image)
        end
    end
    def is_admin?
        role == 'admin'
    end

    def set_slug
        self.slug = "#{id}-#{job_title.to_s.parameterize}"
    end 
end
