  class Sector < ApplicationRecord
      include Filterable
      scope :filter_by_sector_id, -> (sector_id) { where sector_id: sector_id }
      before_save :set_slug
      has_many :blogs
      has_many :events
      
      def is_admin?
        role == 'admin'
      end
      def set_slug
        self.slug = "#{id}-#{name.to_s.parameterize}"
    end 
  end
