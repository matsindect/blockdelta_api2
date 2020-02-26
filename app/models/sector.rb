class Sector < ApplicationRecord
    has_many :blogs
    has_many :events

     # This method tells us if the user is an admin or not.
     def is_admin?
        role == 'admin'
      end
end
