class Job < ApplicationRecord
    include Filterable
    scope :filter_by_category_id, -> (category_id) { where category_id: category_id }
    scope :filter_by_sector_id, -> (sector_id) { where sector_id: sector_id }
    scope :filter_by_job_title, -> (job_title) { where("job_title like ?", "#{job_title}%")}
    after_validation :set_slug, only: [:create, :update]
    belongs_to :sector
    belongs_to :category
    # before_update :set_slug
    # before_create :set_slug
     # This method tells us if the user is an admin or not.
    def is_admin?
        role == 'admin'
    end

    def set_slug
        self.slug = job_title.to_s.parameterize
    end 
end
