class Job < ApplicationRecord
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
