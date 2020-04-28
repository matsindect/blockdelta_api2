class Job < ApplicationRecord
    include Filterable
    scope :filter_by_sector_id, -> (sector_id) { where sector_id: sector_id }
    scope :filter_by_job_title, -> (job_title) { where("job_title like ?", "#{job_title}%")}
    before_save :set_slug
    belongs_to :sector
    
    def is_admin?
        role == 'admin'
    end

    def set_slug
        self.slug = "#{id.to_s}-#{job_title.to_s.parameterize}"
    end 
end
