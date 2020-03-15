class Category < ApplicationRecord
    include Filterable
    scope :filter_by_category_id, -> (category_id) { where category_id: category_id }
    after_validation :set_slug, only: [:create, :update]
    has_many :events
    has_many :blogs
    # before_update :set_slug
    # before_create :set_slug
     # This method tells us if the user is an admin or not.
    def is_admin?
        role == 'admin'
    end
    def set_slug
        self.slug = name.to_s.parameterize
    end 
end
