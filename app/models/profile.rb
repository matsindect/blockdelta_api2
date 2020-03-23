class Profile < ApplicationRecord
    has_many :bloggers
    has_many :candidates
    after_validation :set_slug, only: [:create, :update]

    def is_admin?
        role == 'admin'
    end
    def set_slug
        self.slug = name.to_s.parameterize
    end 
end
