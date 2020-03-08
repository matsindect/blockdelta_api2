  class Sector < ApplicationRecord
      has_many :blogs
      has_many :events
      # before_update :set_slug
      # before_create :set_slug
      # This method tells us if the user is an admin or not.
      def is_admin?
        role == 'admin'
      end
      # def to_slug(name)
      #   name.strip.downcase.gsub(/[\s\.\/\\]/, '-').gsub(/[^\w-]/, '').gsub(/[-_]{2,}/, '-').gsub(/^[-_]/, '').gsub(/[-_]$/, '')
      # end

      # def set_slug
      #     self.update_attribute(:slug, to_slug(self.name))
      # end
  end
