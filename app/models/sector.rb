  class Sector < ApplicationRecord
      
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
