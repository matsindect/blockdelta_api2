class Profile < ApplicationRecord
    has_many :bloggers
    has_many :candidates

     # This method tells us if the user is an admin or not.
     def is_admin?
        role == 'admin'
      end
end
